class UsersController < ApplicationController
  def new
    if Pinkglasses::Application.config.allow_new_user 
      @user = User.new
    else
      ActionController::UnknownAction.new("Disabled action");
    end
  end
  
  def create
    if Pinkglasses::Application.config.allow_new_user 
      @user = User.new(params[:user])
      if @user.save
        redirect_to root_url, :notice => "Signed up!"
      else
        render :new
      end
     else
      ActionController::UnknownAction.new("Disabled action");
    end
  end
end
