# coding: utf-8

class SummaryListsController < ApplicationController

  # --------------------------------------------------------
  # 初期表示                                              --
  # --------------------------------------------------------
  def index
  
    # 検索条件パネルのための仕込み
    @genres = Genre.all
    @ratings = Rating.all
    @commentRegistDateFrom = (Date.today-180).strftime("%Y/%m/%d").to_s
    @commentRegistDateTo = Date.today.strftime("%Y/%m/%d").to_s

    search_commentRegistDateFrom = @commentRegistDateFrom.gsub(/\//, "-") + " 00:00:00.000000"
    search_commentRegistDateTo = @commentRegistDateTo.gsub(/\//, "-") + " 23:59:59.000000"
  
    # ジョイン指示
    @comments = LunchComment.joins(:lunch => :restaurant)
    # 検索範囲日時だけは検索条件とする
    @comments = @comments.where('? <= lunch_comments.updated_at and lunch_comments.updated_at <= ?', search_commentRegistDateFrom, search_commentRegistDateTo)
    # Pagination
    @comments = @comments.paginate(:page => params[:page], :per_page => 10)
    @comments = @comments.all()

    render :search
    
	end

  # --------------------------------------------------------
  # 検索処理                                              --
  # --------------------------------------------------------
  def search

    # 検索条件をパラメータから取り出す
    search_restaurantName  = params[:search][:restaurantName]
    search_address         = params[:search][:address]
    search_genre_id        = params[:search][:genre_id]
    search_rating_id       = params[:search][:rating_id]
    search_reservation     = params[:search][:reservation]

    search_commentRegistDateFrom = params[:search][:commentRegistDateFrom]
    search_commentRegistDateTo   = params[:search][:commentRegistDateTo]
 
    # 検索条件パネルのための仕込み
    @search = Search.new(search_restaurantName, search_address, search_genre_id, search_rating_id, search_reservation)
    @genres = Genre.all()
    @ratings = Rating.all() 
    @commentRegistDateFrom = search_commentRegistDateFrom
    @commentRegistDateTo   = search_commentRegistDateTo
    
    # 日時に関する入力値の型変換
    if !(search_commentRegistDateFrom.blank?)
      search_commentRegistDateFrom = "1000-01-01 00:00:00.000000"
    else
      search_commentRegistDateFrom = search_commentRegistDateFrom.gsub(/\//, "-") + " 00:00:00.000000"
    end
    if !(search_commentRegistDateTo.blank?)
      search_commentRegistDateTo = "9999-12-31 23:59:59.000000"
    else
      search_commentRegistDateTo = search_commentRegistDateTo.gsub(/\//, "-") + " 23:59:59.000000"
    end
    
    # ジョイン指示
    @comments = LunchComment.joins(:lunch => :restaurant)
    
    # 検索範囲日時
    @comments = @comments.where('? <= lunch_comments.updated_at and lunch_comments.updated_at <= ?', search_commentRegistDateFrom, search_commentRegistDateTo)
    
    # 予約可否（チェックがついている場合、予約可を検索、チェックがついていない場合は、検索条件に含めない）
    if !(search_reservation.blank?)
    	@comments = @comments.where('restaurants.reservation = ?', 't')
    end
    
    # レストラン名（あいまい検索）
    if !(search_restaurantName.blank?)
    	@comments = @comments.where('restaurants.name like ?', "%" + search_restaurantName + "%")
    end

    # レストラン住所（あいまい検索）
    if !(search_address.blank?)
    	@comments = @comments.where('restaurants.address like ?', "%" + search_address + "%")
    end
    
    # ジャンル
    if !(search_genre_id.blank?)
      @comments = @comments.where('lunches.genre_id = ?', search_genre_id)
    end

    # 評価
    if !(search_rating_id.blank?)
      @comments = @comments.where('rating_id >= ?', search_rating_id)
    end

    # Pagination
    @comments = @comments.paginate(:page => params[:page], :per_page => 10)

    # SQL発行
    @comments = @comments.all()
    
    render :search
    #respond_to do |format|
    #  format.html # search.html.erb
    #  format.json { render json: @ary }
    #end
  end
  
end
  
