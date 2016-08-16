class PlaysController < ApplicationController
  
  def index
    if params[:data]
      @play = Play.find(params[:data])
    end
    if params[:play]
      @plays = Play.where(catagorie_id: params[:play][:catagorie_id])
    end
    respond_to do |format|
  	  format.html{render 'index'}
      format.js{}
    end
  end

  def new
  	@play = Play.new
    respond_to do |format|
    	format.html{render 'new'}
      format.js{}
    end
  end

  def create
  	@play = Play.new(play_params)
  	if @play.save
      params[:play][:catagorie_id] = 0
  		redirect_to '/plays'
  	else
  		flash[:error] = 'Play did not save.'
  		render 'new'
  	end
  end

  def display
    @plays = Play.where(catagorie_id: params[:play][:catagorie_id])
    respond_to do |format|
      format.js{}
    end
  end

  private

  def play_params
    params.require(:play).permit(:name, :catagorie_id,:image, :notes)
  end
end
