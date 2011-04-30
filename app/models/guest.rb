class Guest < ActiveRecord::Base
	attr_accessible :name, 
									:email, 
									:invite_code, 
									:expected_attendees, 
									:actual_attendees, 
									:party_id

	# Relationships
	belongs_to :party

	# Validations
  validates_presence_of :name, 
												:email, 
												:expected_attendees,
												:party_id
	validates_format_of :email, :with => /^[\w]([^@\s,;]+)@(([\w-]+\.)+(com|edu|org|net|gov|mil|biz|info))$/i, :message => "is not a valid format"
	validates_numericality_of :expected_attendees

	# Callbacks
	before_save :add_invite_code

	# Scopes
	scope :all, order(:name)

	def add_invite_code
		self.invite_code = rand(36**16).to_s(36)
	end
end
