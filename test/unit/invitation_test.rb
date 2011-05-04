require 'test_helper'

class InvitationTest < ActiveSupport::TestCase

	## Testing Relationships ##
  should belong_to(:guest)
  should belong_to(:party)
  should have_many(:gifts)
	should have_one(:host).through(:party)
  
	## Testing Validations ##
  should validate_presence_of(:party_id)
  #should validate_presence_of :guest_id, :message => "can't be blank"
  should validate_numericality_of(:expected_attendees)
  #should validate_numericality_of(:actual_attendees)

	# -------------------------------------------------
  # Testing other methods by setting up a context
  
	context "Creating two invitations for two guests for one party" do
		# create the objects I want with factories
		setup do 
			@party = Party.new
			@party.id = 1

			@guest1 = Guest.new
			@guest1.id = 1
			@guest1.name = "Bob"

			@guest2 = Guest.new
			@guest2.id = 2
			@guest2.name = "Mark"

			@invitation1 = Factory.create(:invitation, :party_id => @party.id, :guest_id => @guest1.id, :expected_attendees => 2, :actual_attendees => 5)
			@invitation2 = Factory.create(:invitation, :party_id => @party.id, :guest_id => @guest2.id, :expected_attendees => 4, :actual_attendees => nil)

			@invitation1.add_invite_code
			@invitation2.add_invite_code
    end
    
    # and provide a teardown method as well
    teardown do
			@invitation2.destroy
			@invitation1.destroy
			@guest2.destroy
			@guest1.destroy
			@party.destroy
    end

		## Testing Creation/Save ##

		# Checks that the locations have the right data by checking one of them
		should "show that the invitations have been created properly" do
			assert_equal @party.id, @invitation2.party_id
			assert_equal @guest2.id, @invitation2.guest_id
			assert_equal 4, @invitation2.expected_attendees
			assert_nil @invitation2.actual_attendees
		end

		should "show that the invitation gets an invite code properly" do			
			assert_not_nil @invitation1.invite_code
		end

		should "show that the invite code isn't overwritten if it alread exists" do
			@oldInviteCode = @invitation2.invite_code
			@invitation2.add_invite_code
			@newInviteCode = @invitation2.invite_code

			assert_equal @oldInviteCode, @newInviteCode
		end

		## Testing Scopes ##

		# scope :all
		should "show that all the invitations are listed by guest_id" do
			assert_equal 2, Invitation.all.size
			assert_equal [1, 2], Invitation.all.map{|i| i.guest_id}
		end
	
		# scope :for_party(host_id)
		should "have scope for_party that works" do
			assert_equal 2, Invitation.for_party(@party.id).size
		end

		# scope :for_guest(guest_id)
		should "have scope for_guest that works" do
			assert_equal 1, Invitation.for_guest(@guest1.id).size
		end

		# scope :get_existing(party_id, guest_id)
		should "have scope get_existing that works" do
			assert_equal 1, Invitation.get_existing(@party.id, @guest1.id).size
		end

		# scope :get_by_invite_code(invite_code)
		should "have scope get_by_invite_code that works" do
			@inviteCode = @invitation1.invite_code
			assert_equal 1, Invitation.get_by_invite_code(@inviteCode).size
		end

		## Testing Callbacks ##

		# Testing this by testing the methods...if the methods work, theres no reason the callback shouldn't
		# before_save :add_invite_code

		## Testing Methods ##

		# add_invite_code - already tested

	end
end
