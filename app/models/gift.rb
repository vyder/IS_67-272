class Gift < ActiveRecord::Base
    attr_accessible :invitation_id, :description, :note_sent_on

		# Relationships
		belongs_to :invitation

		# Validations
		validates_presence_of :description, :note_sent_on

		# Scopes
		scope :all, order(:description)

		# Callbacks - none

end
