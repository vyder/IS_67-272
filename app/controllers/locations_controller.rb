class LocationsController < ApplicationController

	before_filter :login_required

  def index
		@locations = Location.all.for_host(current_host.id).paginate :page => params[:page], :per_page => 12
  end

  def show
    @location = Location.find(params[:id])
  end

  def new
    @location = Location.new
  end

  def create
    @location = Location.new(params[:location])
		@location.host_id = current_host.id
    if @location.save
      flash[:notice] = "Location was successfully created"
      redirect_to @location
    else
      render :action => 'new'
    end
  end

  def edit
    @location = Location.find(params[:id])
  end

  def update
    @location = Location.find(params[:id])
    if @location.update_attributes(params[:location])
      flash[:notice] = "Successfully updated location."
      redirect_to location_url
    else
      render :action => 'edit'
    end
  end

  def destroy
    @location = Location.find(params[:id])
    @location.destroy
    flash[:notice] = "Successfully destroyed location."
    redirect_to locations_url
  end
end
