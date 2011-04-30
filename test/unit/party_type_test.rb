require 'test_helper'

class PartyTypeTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert PartyType.new.valid?
  end
end
