class ItemsController < ApplicationController
  before_filter :require_login, :except => [:not_authenticated]
  
  def index
    challenge
  end

  def challenge
    #item choice
    limit = 20 # a smaller limit increase query speed, a greater limit enhance user experience when reloading challenge page (blank vote)
    items = Item.limit(limit).order("updated_at ASC") # take only a few of the least recently voted pics  
    @lItem = items[Random.rand(limit/2)] # choose one randomly in first half
    @rItem = items[Random.rand((limit/2) - 1) + limit/2] # choose another in second half
    
    # validity, user can only vote for those two
    session[:items] = [@rItem.id.to_s, @lItem.id.to_s]
    
    # view parameters 
    url = "TODO !"
    title = "ENSIIE pink glasses challenge"
    @twitterLink = twitter_link(url, title)
    @facebookLink = facebook_link(url, title)
  end

  def show
    @item = Item.find(params[:id])
    # view parameters 
    # request.env["SERVER_ADDR"]
    url = "TODO !"
    title = "ENSIIE pink glasses challenge"
    @twitterLink = twitter_link(url, title)
    @facebookLink = facebook_link(url, title)
  end

  def random
    @item = Item.random
    # view parameters 
    # request.env["SERVER_ADDR"]
    url = "TODO !"
    title = "ENSIIE pink glasses challenge"
    @twitterLink = twitter_link(url, title)
    @facebookLink = facebook_link(url, title)
  end

  def ranking
    @items = Item.order('score DESC').page(params[:page]).per(5)
    # view parameters 
    # request.env["SERVER_ADDR"]
    url = "TODO !"
    title = "ENSIIE pink glasses challenge"
    @twitterLink = twitter_link(url, title)
    @facebookLink = facebook_link(url, title)
  end


end
