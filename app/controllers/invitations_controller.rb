class InvitationsController < ApplicationController

	before_filter :login_required, :except => :rsvp

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

		@oldInvitation = Invitation.get_existing(@invitation.party_id, @invitation.guest_id).first
		@flashMsg = ""

		if( !@oldInvitation.nil? )
			# Save the invite_code, so it stays the same
			@invitation.invite_code = @oldInvitation.invite_code

			# Update flash message
			@flashMsg = "The invitation for this guest has been updated.\n"
			
			# Destroy old invitation
			@oldInvitation.destroy
		end

		if @invitation.save
			# Mail out the invitation to the guest
			InvitationMailer.new_invitation_msg(@invitation).deliver

			@flashMsg += "Invitation was successfully created, #{@invitation.guest.name} has been notified by email"
			redirect_to @invitation
		else
			render :action => 'new'
		end

		flash[:notice] = @flashMsg
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

	def rsvp
		@invitation = Invitation.new
		if params.has_key?(:invite_code)
			@invite_code = params[:invite_code]
		end
	end

	def invite
		@invitation = Invitation.get_by_invite_code(params[:invite_code]).first
		if !@invitation.nil?
			@party = @invitation.party
			@invitation_id = @invitation.id
		end
	end

	def rsvp_complete
		@invitation = Invitation.find(params[:id])
		@actual_attendees = params[:invitation_actual_attendees]
		@invitation.actual_attendees = @actual_attendees

		if @invitation.update_attributes(params[:invitation])
      flash[:notice] = "Successfully updated invitation."
    end
	end

  def destroy
    @invitation = Invitation.find(params[:id])
    @invitation.destroy
    flash[:notice] = "Successfully destroyed invitation."
    redirect_to invitations_url
  end
end
