require 'test_helper'

class PartyTypeTest < ActiveSupport::TestCase

	## Testing Relationships ##
  should have_many(:parties)
  
	## Testing Validations ##
  should validate_presence_of(:name)

	# -------------------------------------------------
  # Testing other methods by setting up a context
  
	context "Creating two party types one party" do
		# create the objects I want with factories
		setup do 
			@birthday = Factory.create(:party_type, :name => "Birthday")
			@graduation = Factory.create(:party_type, :name => "Graduation")
    end
    
    # and provide a teardown method as well
    teardown do
			@birthday.destroy
			@graduation.destroy
		end

		## Testing Creation/Save ##

		# Checks that the party types have the right data by checking one of them
		should "show that the party types have been created properly" do
			assert_equal "Birthday", @birthday.name
		end

		## Testing Scopes ##

		# scope :all
		should "show that all the party types are listed by name" do
			assert_equal 2, PartyType.all.size
			assert_equal ["Birthday", "Graduation"], PartyType.all.map{|p| p.name}
		end


		## Testing Callbacks ## - none

		## Testing Methods ## - none

	end
end
