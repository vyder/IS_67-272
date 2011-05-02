class InvitationsController < ApplicationController

	before_filter :login_required

  def index
		# current_host.invitations is a 2D array, need to flatten it for pagination
		@invitations = current_host.invitations.flatten.paginate 	:page => params[:page], :per_page => 12
  end

  def show
    @invitation = Invitation.find(params[:id])
  end

  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new(params[:invitation])

		@invitationExists = Invitation.for_party(@invitation.party_id).for_guest(@invitation.guest_id)

		if ( @invitationExists.nil? || @invitationExists.empty? )
			#if Invitation.all.include?(@invitation)
			@invitation = Invitation.find(params[:id])
	    if @invitation.update_attributes(params[:invitation])
  	    flash[:notice] = "The invitation for this guest has been updated."
  	    redirect_to invitation_url
  	  else
  	    render :action => 'edit'
  	  end
		else
			@invitation.actual_attendees = -1
			if @invitation.save
		    flash[:notice] = "Invitation was successfully created"
		    redirect_to @invitation
		  else
		    render :action => 'new'
		  end
		end
  end

  def edit
    @invitation = Invitation.find(params[:id])
  end

  def update
    @invitation = Invitation.find(params[:id])
    if @invitation.update_attributes(params[:invitation])
      flash[:notice] = "Successfully updated invitation."
      redirect_to invitation_url
    else
      render :action => 'edit'
    end
  end

  def destroy
    @invitation = Invitation.find(params[:id])
    @invitation.destroy
    flash[:notice] = "Successfully destroyed invitation."
    redirect_to invitations_url
  end
end
