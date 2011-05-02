class Invitation < ActiveRecord::Base
    attr_accessible :party_id, :guest_id, :invite_code, :expected_attendees, :actual_attendees

		# Relationships
		belongs_to :guest
		belongs_to :party
		has_many :gifts
		has_one :host, :through => :party

		# Validations
		validates_presence_of :party_id
		validates_presence_of :guest_id, :message => "Guest is not a number"
		validates_numericality_of :expected_attendees, :only_integer => true, :greater_than => 0

		# Scopes
		scope :all, order(:guest_id)
		scope :for_party, lambda { |party_id|
			{ :conditions => ["party_id = ?", party_id] }
		}
		scope :for_guest, lambda { |guest_id|
			{ :conditions => ["guest_id = ?", guest_id] }
		}

		# Callbacks
		before_save :add_invite_code

		# Model Methods
		def add_invite_code
			self.invite_code = rand(36**16).to_s(36)
		end

end
