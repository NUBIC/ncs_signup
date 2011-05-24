class SignUpController < ApplicationController

  def new
    @participant = Participant.new 
  end

  def create
    @participant = Participant.new(params[:participant])
    if @participant.save
      render :action => "show"
    else
      flash[:msg] = "Almost finished! Please correct these:"
      render :action => "new"
    end
  end

  def show
    
  end

end

