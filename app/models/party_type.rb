class PartyType < ActiveRecord::Base
    attr_accessible :name, :active

		# Relationships
		has_many :parties

		# Validations
		validates_presence_of :name, :active

		# Scopes
		scope :all, order(:name)

end
