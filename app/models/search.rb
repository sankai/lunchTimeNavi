class Search

  attr_accessor :restaurantName, :address, :genre_id, :rating_id, :reservation, :commentRegistDateFrom, :commentRegistDateTo

  def initialize(params)
    unless params.nil?
      @restaurantName        = params[:restaurantName]
      @address               = params[:address]
      @genre_id              = params[:genre_id]
      @rating_id             = params[:rating_id]
      @reservation           = params[:reservation]
      @commentRegistDateFrom = params[:commentRegistDateFrom]
      @commentRegistDateTo   = params[:commentRegistDateTo]
    end
  end
end
