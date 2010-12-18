class QuestionVotesController < ApplicationController

  def create
    vote = QuestionVote.find(:first, :conditions => {:user_id => current_user.id, :question_id => params[:question_id]})
    vote ||= QuestionVote.new(:user => current_user, :question_id => params[:question_id])
    if params[:vote] == "up"
      vote.upvote = true
    else
      vote.upvote = false
    end

    vote.save

    render :text => "ok"
  end

end
