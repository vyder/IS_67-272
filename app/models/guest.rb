class Guest < ActiveRecord::Base
    attr_accessible :name, :email, :invite_code, :expected_attendees, :actual_attendees
end
