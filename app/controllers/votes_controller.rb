class VotesController < ApplicationController

  before_action :authenticate

  def index
    total_votes = Vote.where(:tombstone => nil).count
    @votes = Vote
      .joins(:proposal)
      .where(votes: { :tombstone => nil, :user_id => @current_user })
      .all
    @votes.map { |v| v.proposal.percent = v.proposal.votes / (0.01*total_votes) }
  end

  def create
    votes = Vote.where(:tombstone => nil, :user_id => @current_user).all
    if params[:cid].present? && votes.length < Rails.configuration.x.max_votes_per_person
      @proposal = Proposal.find(params[:cid])
      if (@proposal.present?) && (not votes.all.map { |v| v.proposal_id } .include?(@proposal.id))
        @vote = Vote.new(proposal_id: params[:cid])
        add_client_info(@vote)
        @proposal.votes += 1
        @vote.save
        @proposal.save
      end
    end
    redirect_to votes_path
  end

  def destroy
    @vote = Vote.find(params[:id])
    @proposal = Proposal.find(@vote.proposal_id)
    @proposal.votes -= 1
    @vote.tombstone = true
    @vote.save
    @proposal.save

    redirect_to votes_path
  end

private

  def add_client_info(vote)
    headers = get_headers
    vote.headers = headers.inspect
    vote.user_id = @current_user
    vote.client_ip = headers['HTTP_X_FORWARDED_FOR']
    vote.user_agent = headers['HTTP_USER_AGENT']
  end
end
