class Party < ActiveRecord::Base
    attr_accessible :name, :date, :location, :start_time, :end_time, :description, :rsvp_date
end
