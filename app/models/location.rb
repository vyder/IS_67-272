class Location < ActiveRecord::Base
    attr_accessible :name, :host_id, :street, :city, :state, :zip, :latitude, :longitude

		# Relationships
		belongs_to :host
		has_many :parties

		# Validations
		validates_presence_of :name, :street, :city, :state, :zip, :host_id
		validates_format_of :zip, 	:with => /^\d{5}$/, 
																:message => "zip code should be 5 digits only"

		# Scopes
		scope :all, order(:name)
		scope :for_host, lambda { |host_id| # ** Don't change 'host_id' to 'host', populate.rake passes an id to for_host
			{ :conditions => ["host_id = ?", host_id] }
		}

	  # Callback
		before_save :find_location_coordinates

		# List of states for drop down menu
		STATES_LIST = [['Alabama', 'AL'],['Alaska', 'AK'],['Arizona', 'AZ'],['Arkansas', 'AR'],['California', 'CA'],['Colorado', 'CO'],['Connectict', 'CT'],['Delaware', 'DE'],['District of Columbia ', 'DC'],['Florida', 'FL'],['Georgia', 'GA'],['Hawaii', 'HI'],['Idaho', 'ID'],['Illinois', 'IL'],['Indiana', 'IN'],['Iowa', 'IA'],['Kansas', 'KS'],['Kentucky', 'KY'],['Louisiana', 'LA'],['Maine', 'ME'],['Maryland', 'MD'],['Massachusetts', 'MA'],['Michigan', 'MI'],['Minnesota', 'MN'],['Mississippi', 'MS'],['Missouri', 'MO'],['Montana', 'MT'],['Nebraska', 'NE'],['Nevada', 'NV'],['New Hampshire', 'NH'],['New Jersey', 'NJ'],['New Mexico', 'NM'],['New York', 'NY'],['North Carolina','NC'],['North Dakota', 'ND'],['Ohio', 'OH'],['Oklahoma', 'OK'],['Oregon', 'OR'],['Pennsylvania', 'PA'],['Rhode Island', 'RI'],['South Carolina', 'SC'],['South Dakota', 'SD'],['Tennessee', 'TN'],['Texas', 'TX'],['Utah', 'UT'],['Vermont', 'VT'],['Virginia', 'VA'],['Washington', 'WA'],['West Virginia', 'WV'],['Wisconsin ', 'WI'],['Wyoming', 'WY']]

	# Functions
	# Create a static map - ## not required since dynamic maps have been implemented
	# def create_map_link
	#		locationMarker = "&markers=color:red%7Ccolor:red%7C#{latitude},#{longitude}"
	#		map = "http://maps.google.com/maps/api/staticmap?center=#{latitude},#{longitude}&zoom=15&size=350x350&maptype=roadmap#{locationMarker}&sensor=false"
	#		return true
	#	end

	private
	def find_location_coordinates
		begin
			coord = Geokit::Geocoders::GoogleGeocoder.geocode "#{street}, #{city}, #{state}, #{zip}"
			if coord.success
				self.latitude, self.longitude = coord.ll.split(',')
			else
				return false
			end
		rescue
			return false
		end

		return true
	end

end
