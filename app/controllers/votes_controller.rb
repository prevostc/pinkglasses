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
          # don't push vote if spam but do not yield any error
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
    redirect_to challenge_items_path(:anchor => "items")
  end

  def spam? hot, nhot
    vote_frequency_spam? 1
  end 
  
  def get_new_scores(hot, nhot)

    # int to float, add precision while dividing
    hot  = hot.to_f 
    nhot = nhot.to_f

    # parametrize ELO algorithme
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

  # consider the request as spam if the last request was less than min_sec_between_2_votes seconds ago
  # where min_sec_between_2_votes is a Float
  def vote_frequency_spam? min_sec_between_2_votes
    if session[:last_vote_time].nil? then
      # first vote, init session last vote time
      session[:last_vote_time] = Time.now
      logger.debug "Spam detector first vote at '#{session[:last_vote_time]}'"
      false
    else
      # all other votes
      # get Times
      last_vote = session[:last_vote_time]
      now = Time.now
      # update last vote in any cases
      session[:last_vote_time] = now
      # get delta
      delta = now - last_vote # this returns a Float, # of sec
      # spam if delta < min_sec_between_2_votes sec
      if delta.abs <= min_sec_between_2_votes then
        logger.info "Spam detected, last vote at '#{last_vote}', current vote at '#{now}', delta = '#{delta}'"
        true
      else
        logger.debug "Spam passed, last vote at '#{last_vote}', current vote at '#{now}', delta = '#{delta}'"
        false
      end 
    end
  end
  

end
