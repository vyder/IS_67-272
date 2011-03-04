require 'test_helper'

class GuestTest < ActiveSupport::TestCase
#  def test_should_be_valid
#    assert Guest.new.valid?
#  end

	# -------------------------------------------------
  # More shoulda testing for the other methods, etc.
  # by setting up context(s)
  #

	# ------------------------------------------------------------------
  # Context to test basic guest functionality
	context "Generates invite code correctly" do
		setup do
			@guest = Factory.create(:guest)
		end

		teardown do
			@guest.destroy
		end

		# now run the tests:

		# test the invite code is not nil
		should "invite code is not null" do
			assert_not_nil @guest.invite_code, "Invite code is nil"
		end
	end

end
