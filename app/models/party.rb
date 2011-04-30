class Party < ActiveRecord::Base
	attr_accessible :name, 
									:party_date, 
									:location, 
									:start_time, :end_time, 
									:description, 
									:rsvp_date,
									:host_id,
									:location_id,
									:party_type_id

	# Relationships
	belongs_to :host
	belongs_to :party_type
	belongs_to :location
	has_many :guests

	# Validations
  validates_presence_of :name, 
												:party_date, 
												:location, 
												:start_time, :end_time
	validate :party_date_is_valid
	validate :rsvp_date_is_valid
	validate :party_times_are_valid

	# Scopes
	scope :all, order(:party_date)

	# Methods
	def confirmed
		self.guests.sum('actual_attendees')
	end

	def expected
		self.guests.sum('expected_attendees')
	end

	# Validation Methods
	def party_date_is_valid
		errors.add(:party_date, 'Party date must be on or after today') if party_date < Date.today
	end

	def rsvp_date_is_valid
		errors.add(:rsvp_date, 'Rsvp date must be on or before') if !rsvp_date.nil? && party_date < rsvp_date
	end

	def party_times_are_valid
		errors.add(:end_time, 'End time must be after Start time') if end_time <= start_time
	end

end
