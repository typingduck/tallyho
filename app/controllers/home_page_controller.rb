class HomePageController < ApplicationController
  def index
    @top_proposals = Proposal.order(votes: :desc).limit(5)
    total_votes = Vote.where(:tombstone => nil).count
    @top_proposals.map { |c| c.percent = c.votes / (0.01*total_votes) }
  end
end
