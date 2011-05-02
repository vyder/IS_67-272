class InvitationMailer < ActionMailer::Base

  default :from => "from@example.com"

	def new_invitation_msg(invitation)
		@invitation = invitation

		@party = @invitation.party
		@guest = @invitation.guest

		@invite_code = @invitation.invite_code

		mail(:to => @guest.email, :subject => "Join the Party!")
	end

	def remove_invitation_msg
	end

end
