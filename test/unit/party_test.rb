require 'test_helper'

class PartyTest < ActiveSupport::TestCase

	## Testing Relationships ##
  should belong_to(:host)
	should belong_to(:party_type)
	should belong_to(:location)
  should have_many(:invitations)
	should have_many(:guests).through(:invitations)
  
	## Testing Validations ##
  should validate_presence_of(:name)
  should validate_presence_of(:host_id)
  should validate_presence_of(:party_date)
  should validate_presence_of(:location_id)
  should validate_presence_of(:start_time)
  should validate_presence_of(:end_time)

	# -------------------------------------------------
	# Testing other methods by setting up a context
	
	context "Creating two parties for one host" do
		# create the objects I want with factories
		setup do 
			@host = Host.new
			@host.id = 1

			@party1 = Party.new
			@party1.name = "Birthday"
			@party1.host_id = @host.id

			@party2 = Factory.create(:party, :host_id => @host.id, :name => "Graduation")
		end
		
		# and provide a teardown method as well
		teardown do
			@party2.destroy
			@party1.destroy
			@host.destroy
		end

		## Testing Creation/Save ##

		# Checks that the parties have the right data by checking one of them
		should "show that the parties is created properly" do
			assert_equal "Birthday", @party1.name
			assert_equal @host.id, @party1.host_id
		end

		## Testing Scopes ##

		# scope :all
		should "show that all the parties are listed alphabetically" do
			assert_equal 2, Party.all.size
			assert_equal ["Birthday", "Graduation"], Party.all.map{|p| p.name}
		end
	
		# scope :for_host(host_id)
		should "have scope for_host that works" do
			assert_equal 2, Party.for_host(1).size
		end

		## Testing Callbacks ## - none to test

		## Testing Methods ## - none to test

	end

end
