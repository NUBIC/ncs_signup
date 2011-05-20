class SignUpController < ApplicationController

  def new
    @participant = Participant.new 
  end

  def create
    render :action => "show"
  end

  def show
    
  end

end

