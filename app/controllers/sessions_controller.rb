class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    user = login(params[:username], params[:password], params[:remember_me])
    if user
      redirect_back_or_to root_url, :notice => "Logged in!"
    else
      flash.now.alert = "Login or password was invalid"
      render :new
    end
  end
  
  def destroy
    logout
    redirect_to new_session_url, :notice => "Logged out!"
  end
  
  # clean old sessions
  def self.cleanup(period = 48.hours.ago)
    session_store = ActiveRecord::SessionStore::Session
    session_store.destroy_all ['updated_at < ?', period]
  end

end
