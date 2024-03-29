class PartiesController < ApplicationController

	before_filter :login_required
  
	def index
    @parties = Party.for_host(current_host).by_name.paginate :page => params[:page], :per_page => 12
  end

  def show
    @party = Party.find(params[:id])
		@invitations = @party.invitations
  end

  def new
    @party = Party.new
  end

  def create
    @party = Party.new(params[:party])
		@party.host_id = current_host.id
    if @party.save
      flash[:notice] = "Successfully created party."
      redirect_to @party
    else
      render :action => 'new'
    end
  end

  def edit
    @party = Party.find(params[:id])
  end

  def update
    @party = Party.find(params[:id])
    if @party.update_attributes(params[:party])
      flash[:notice] = "Successfully updated party."
      redirect_to party_url
    else
      render :action => 'edit'
    end
  end

  def destroy
    @party = Party.find(params[:id])
    @party.destroy
    flash[:notice] = "Successfully destroyed party."
    redirect_to parties_url
  end
end
