class ProposalsController < ApplicationController

  before_action :authenticate, except: [:show]

  def disabled_index
    @proposals = Proposal.all
  end

  def new
    @proposal = Proposal.new
  end

  def create
    proposal_params = params.require(:proposal).permit(:name, :link, :bio)
    proposal_params[:user_id] = @current_user
    @proposal = Proposal.new(proposal_params)
    @proposal.votes ||= 0
    if @proposal.save
      redirect_to @proposal
    else
      render 'new'
    end
  end

  def show
    @proposal = Proposal.find(params[:id])
  end

end
