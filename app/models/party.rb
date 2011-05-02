class Party < ActiveRecord::Base

	attr_accessible :name,
									:host_id,
									:party_type_id,
									:party_date,
									:location_id,
									:start_time, :end_time, 
									:description, 
									:rsvp_date

	# Relationships
	belongs_to :host
	has_many :invitations
	belongs_to :party_type
	belongs_to :location
	has_many :guests, :through => :invitations

	# Validations
  validates_presence_of :name, :host_id,
												:party_date,
												:location_id,
												:start_time, :end_time
	validates_presence_of :party_type_id, :message => "Party type is not a number"
	validates_date :party_date, :after => Date.today, :after_message => "must be on or after"
	validates_date :rsvp_date, :before => :party_date, :allow_blank => true, :before_message => "must be on or before"
	validates_time :end_time, :after => :start_time

	# Old code - installed gem 'validates_timeliness'
	#validate :party_date_is_valid
	#validate :rsvp_date_is_valid
	#validate :party_times_are_valid

	# Scopes
	scope :all, :order => "name"
	scope :by_name, :order => "name"
	scope :upcoming, :order => "party_date, start_time"
	scope :for_host, lambda { |host_id| 
		{ :conditions => ["host_id = ?", host_id] }
	}

	# Callbacks - none

	# Methods
	def confirmed
		self.invitations.sum('actual_attendees')
	end

	def expected
		self.invitations.sum('expected_attendees')
	end

	# Old code - installed gem 'validates_timeliness'
	# Validation Methods
	#def party_date_is_valid
	#	errors.add(:party_date, 'Party date must be on or after today') if party_date < Date.today
	#end

	#def rsvp_date_is_valid
	#	errors.add(:rsvp_date, 'Rsvp date must be on or before') if !rsvp_date.nil? && party_date < rsvp_date
	#end

	#def party_times_are_valid
	#	errors.add(:end_time, 'End time must be after Start time') if end_time <= start_time
	#end

end
