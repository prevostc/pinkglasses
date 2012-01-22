class VotesController < ApplicationController
  before_filter :require_login, :except => [:not_authenticated]
  
  # create new vote
  def new
    if params[:hot] and params[:not] then
      
      # get items
      @hot = Item.find(params[:hot].to_i)
      @not = Item.find(params[:not].to_i)
      
      # test if items are valid records
      if not @hot.nil? and not @not.nil? then
        if spam?(@hot,@not) then
          # don't push vote if spam
        else
          # create new vote 
          @vote = Vote.new(:hot => @hot.id, :not => @not.id);
          @hot.score, @not.score = get_new_scores(@hot.score, @not.score)
          Vote.transaction do
            @vote.save
            @hot.save
            @not.save
          end
        end
      end
    end
    redirect_to challenge_items_path()
  end

  def spam? hot, nhot
    false
  end 
  
  def get_new_scores(hot, nhot)

    # @see elo.js 

    hot  = hot.to_f
    nhot = nhot.to_f

    kValue = 20.0
    dValue = 300.0

    expectedChanceHot  = 1.0 / (1.0 + (10.0 ** ((nhot - hot) / dValue)))
    expectedChanceNhot = 1.0 / (1.0 + (10.0 ** ((hot - nhot) / dValue)))
    changeHot  = kValue * (1.0 - expectedChanceHot)
    changeNhot = kValue * (0.0 - expectedChanceNhot)

    newRatingHot  = hot + changeHot
    newRatingNhot = nhot + changeNhot

    return [ newRatingHot.to_i, newRatingNhot.to_i ]
  end

end
