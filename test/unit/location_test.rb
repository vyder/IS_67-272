# ** format for these tests are from PATS by the klingoncodewarrior
# ** check his github - https://github.com/klingoncodewarrior/67272-S11_PATSv1/blob/master/test/unit/pet_test.rb	

require 'test_helper'

class LocationTest < ActiveSupport::TestCase

	## Testing Relationships ##
  should belong_to(:host)
  should have_many(:parties)
  
	## Testing Validations ##
  should validate_presence_of(:name)
  should validate_presence_of(:street)
  should validate_presence_of(:city)
  should validate_presence_of(:state)
  should validate_presence_of(:zip)
  should validate_presence_of(:host_id)

	# -------------------------------------------------
  # Testing other methods by setting up a context
  
	context "Creating three locations for two hosts" do
		# create the objects I want with factories
		setup do 
			@fairfax = Factory.create(:location, :name => "Fairfax", :street => "4614 Fifth Ave", :city => "Pittsburgh", :state => "PA", :zip => "15289", :host_id => "1")
			@cmu = @fairfax = Factory.create(:location, :name => "CMU", :street => "5000 Forbes Ave", :city => "Pittsburgh", :state => "PA", :zip => "15289", :host_id => "1")
			@stever = Factory.create(:location, :name => "Stever", :street => "1060 Morewood Ave", :city => "Pittsburgh", :state => "PA", :zip => "15289", :host_id => "2")
    end
    
    # and provide a teardown method as well
    teardown do
			@fairfax.destroy
			@cmu.destroy
			@stever.destroy
    end

		## Testing Creation/Save ##

		# Checks that the locations have the right data by checking one of them
		should "show that the locations have been created properly" do
			assert_equal "CMU", @cmu.name
			assert_equal "5000 Forbes Ave", @cmu.street
			assert_equal "Pittsburgh", @cmu.city
			assert_equal "PA", @cmu.state
			assert_equal 15289, @cmu.zip
			assert_equal 1, @cmu.host_id
		end

		## Testing Scopes ##

		# scope :all
		should "show that all the locations are listed by name" do
			assert_equal 3, Location.all.size
			assert_equal ["CMU", "Fairfax", "Stever"], Location.all.map{|loc| loc.name}
		end
	
		# scope :for_host(host_id)
		should "have scope for_host that works" do
			assert_equal 2, Location.for_host(1).size
			assert_equal 1, Location.for_host(2).size
		end

		## Testing Callbacks ##

		# Testing this by testing the methods...if the methods work, theres no reason the callback shouldn't
		# before_save :find_location_coordinates

		## Testing Methods ##

		should "find the location's coordinates" do
			# Get fairfax to find its latitude and longitude
			@fairfax.find_location_coordinates

			assert_equal "40.4435037", @fairfax.latitude
			assert_equal "-79.9415706", @fairfax.longitude
		end

	end
end

# The following code makes Loction's private methods public for testing purposes only.
# The methods-get un-publicized once you leave this file (i think...not too sure)
class Location
	public :find_location_coordinates
end
