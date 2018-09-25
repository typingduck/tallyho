class SearchController < ApplicationController

  def proposals
    name = params[:name]
    if name.present?
      proposals = Proposal
        .where('name ILIKE ?', "%#{name}%").limit(5)
        .map { |c| { :id => c.id, :name => c.name } }
    else
      proposals = []
    end
    render :json => proposals
  end

end
