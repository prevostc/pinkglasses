class ItemsController < ApplicationController
  before_filter :require_login, :except => [:not_authenticated]
  
  def index
    challenge
  end

  def challenge
    # left item choice 
    @lItem = Item.random
    
    # right item choice (different from lItem)  
    stop = false
    while not stop do
      @rItem = Item.random
      if @rItem.id != @lItem.id then
        stop = true
      end
    end
    
    # view parameters 
    url = ""
    title = "Awesome boo..braaaain !"
    @twitterLink = twitter_link(url, title)
    @facebookLink = facebook_link(url, title)
  end

  def show
    @item = Item.find(params[:id])
    # view parameters 
    # request.env["SERVER_ADDR"]
    url = ""
    title = "Leave it to luck !"
    @twitterLink = twitter_link(url, title)
    @facebookLink = facebook_link(url, title)
  end

  def random
    @item = Item.random
    # view parameters 
    # request.env["SERVER_ADDR"]
    url = ""
    title = "Leave it to luck !"
    @twitterLink = twitter_link(url, title)
    @facebookLink = facebook_link(url, title)
  end

  def ranking
    @items = Item.order('score DESC').page(params[:page]).per(5)
    # view parameters 
    # request.env["SERVER_ADDR"]
    url = ""
    title = "Caution, may break your eyes !"
    @twitterLink = twitter_link(url, title)
    @facebookLink = facebook_link(url, title)
  end


end
