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
    @comments = @comments.order('lunches.restaurant_id DESC, lunch_id DESC, id DESC')
    @comments = @comments.paginate(:page => params[:page], :per_page => 10)
    @comments = @comments.all()

    render :search
    
	end

  # --------------------------------------------------------
  # 検索処理                                              --
  # --------------------------------------------------------
  def search

    if params[:page].nil?
      # 初回検索のとき（ページ繰りしていないとき）
      # 検索条件をオブジェクトにして、セッションにセット
      @search = Search.new(params[:search])
      session[:search] = @search
    else
      @search = session[:search]
    end
    
    # 検索条件パネルのための仕込み
    @genres  = Genre.all()
    @ratings = Rating.all() 
    @commentRegistDateFrom = @search.commentRegistDateFrom
    @commentRegistDateTo   = @search.commentRegistDateTo
    
    # 日時に関する入力値の型変換
    if (@search.commentRegistDateFrom.blank?)
      @search.commentRegistDateFrom = "2000-01-01 00:00:00.000000"
    end
    if (@search.commentRegistDateTo.blank?)
      @search.commentRegistDateTo   = "2020-12-31 23:59:59.000000"
    end
    
    # ジョイン指示
    @comments = LunchComment.joins(:lunch => :restaurant)
    
    # 検索範囲日時
    @comments = @comments.where('? <= lunch_comments.updated_at and lunch_comments.updated_at <= ?', @search.commentRegistDateFrom, @search.commentRegistDateTo)
    
    # 予約可否（チェックがついている場合、予約可を検索、チェックがついていない場合は、検索条件に含めない）
    if !(@search.reservation.blank?)
    	@comments = @comments.where('restaurants.reservation = ?', 't')
    end
    
    # レストラン名（あいまい検索）
    if !(@search.restaurantName.blank?)
    	@comments = @comments.where('restaurants.name like ?', "%" + @search.restaurantName + "%")
    end

    # レストラン住所（あいまい検索）
    if !(@search.address.blank?)
    	@comments = @comments.where('restaurants.address like ?', "%" + @search.address + "%")
    end
    
    # ジャンル
    if !(@search.genre_id.blank?)
      @comments = @comments.where('lunches.genre_id = ?', @search.genre_id)
    end

    # 評価
    if !(@search.rating_id.blank?)
      @comments = @comments.where('rating_id >= ?', @search.rating_id)
    end

    # Pagination
    @comments = @comments.order('lunches.restaurant_id DESC, lunch_id DESC, id DESC')
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
  
