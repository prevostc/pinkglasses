class UsersController < ApplicationController
  def new
    if PinkGlasses::Application.config.allow_new_user 
      @user = User.new
    else
      redirect_to root_url
    end
  end
  
  def create
    if PinkGlasses::Application.config.allow_new_user 
      @user = User.new(params[:user])
      if @user.save
        redirect_to root_url, :notice => "Signed up!"
      else
        render :new
      end
     else
      redirect_to root_url
    end
  end
end
