class Guest < ActiveRecord::Base
	attr_accessible :name, 
									:email,
									:host_id,
									:notes

	# Relationships
	belongs_to :host
	has_many :invitations
	has_many :parties, :through => :invitations

	# Validations
  validates_presence_of :name, :email, :host_id
	validates_format_of :email, :with => /^[\w]([^@\s,;]+)@(([\w-]+\.)+(com|edu|org|net|gov|mil|biz|info))$/i, :message => "is not a valid format"

	# Callbacks - none

	# Scopes
	scope :all, order(:name)
	scope :for_host, lambda { |host_id| # ** Don't change 'host_id' to 'host', populate.rake passes an id to for_host
		{ :conditions => ["host_id = ?", host_id] }
	}

end
