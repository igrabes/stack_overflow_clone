class VotesController < ApplicationController

  def create
    params[:vote][:user_id] = current_user.id if current_user

    search_params = params[:vote].clone
    search_params[:user_id] ||= -1
    search_params.delete :value

    vote = Vote.find(:first, :conditions => search_params)
    vote ||= Vote.new(params[:vote])
    vote.value = params[:vote][:value]

    ret = {:success => vote.save}
    if ret[:success]
      ret.merge!({:score => vote.voteable.score, :upvote => vote.value == 1, :downvote => vote.value == -1})
    else
      ret[:error] = vote.errors
    end

    render :json => ret;
  end

end
