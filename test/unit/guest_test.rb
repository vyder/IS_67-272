# ** format for these tests are from PATS by the klingoncodewarrior
# ** check his github - https://github.com/klingoncodewarrior/67272-S11_PATSv1/blob/master/test/unit/pet_test.rb

require 'test_helper'

class GuestTest < ActiveSupport::TestCase

	## Testing Relationships ##
  should belong_to(:host)
  should have_many(:invitations)
  should have_many(:parties).through(:invitations)
  
	## Testing Validations ##
  should validate_presence_of(:name)
  should validate_presence_of(:email)
  should validate_presence_of(:host_id)

	# -------------------------------------------------
	# Testing other methods by setting up a context
	
	context "Creating three guests for two hosts" do
		# create the objects I want with factories
		setup do 
			@guest1 = Factory.create(:guest, :name => "Bob", :email => "bob@example.com", :host_id => "1")
			@guest2 = Factory.create(:guest, :name => "Jack", :email => "jack@example.com", :host_id => "1")
			@guest3 = Factory.create(:guest, :name => "Mark", :email => "mark@example.com", :host_id => "2")
		end
		
		# and provide a teardown method as well
		teardown do
			@guest1.destroy
			@guest2.destroy
			@guest3.destroy
		end

		## Testing Creation/Save ##

		# Checks that the guests have the right data by checking one of them
		should "show that the guests is created properly" do
			assert_equal "Bob", @guest1.name
			assert_equal "bob@example.com", @guest1.email
		end

		## Testing Scopes ##

		# scope :all
		should "show that all the guest are listed alphabetically" do
			assert_equal 3, Guest.all.size
			assert_equal ["Bob", "Jack", "Mark"], Guest.all.map{|g| g.name}
		end
	
		# scope :for_host(host_id)
		should "have scope for_host that works" do
			assert_equal 2, Guest.for_host(1).size
			assert_equal 1, Guest.for_host(2).size
		end

		## Testing Callbacks ## - none to test

		## Testing Methods ## - none to test

	end

end
