class Invitation < ActiveRecord::Base
    attr_accessible :party_id, :guest_id, :invite_code, :expected_attendees, :actual_attendees

		# Relationships
		belongs_to :guest
		belongs_to :party
		has_many :gifts
		has_one :host, :through => :party

		# Validations
		validates_presence_of :party_id, :on => :create
		validates_presence_of :guest_id, :message => "Guest is not a number", :on => :create
		validates_numericality_of :expected_attendees, :only_integer => true, :greater_than => 0, :on => :create
		validates_numericality_of :actual_attendees, :only_integer => true, :greater_than_or_equal_to => 0, :on => :update

		# Scopes
		scope :all, order(:guest_id)
		scope :for_party, lambda { |party_id|
			{ :conditions => ["party_id = ?", party_id] }
		}
		scope :for_guest, lambda { |guest_id|
			{ :conditions => ["guest_id = ?", guest_id] }
		}
		scope :get_existing, lambda { |party_id, guest_id|
			{ :conditions => ["party_id = ? AND guest_id = ?", party_id, guest_id] }
		}
		scope :get_by_invite_code, lambda { |invite_code|
			{ :conditions => ["invite_code = ?", invite_code] }
		}

		# Callbacks
		before_save :add_invite_code

		# Model Methods
		def add_invite_code
			self.invite_code = rand(36**16).to_s(36) unless !self.invite_code.nil?
		end

end
