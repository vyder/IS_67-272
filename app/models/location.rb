class Location < ActiveRecord::Base
    attr_accessible :name, :street, :city, :state, :zip, :latitude, :longitude

		# Relationships
		belongs_to :host
		has_many :parties

		# Validations
		validates_presence_of :name, :street, :city, :state, :zip
		validates_format_of :zip, 	:with => /^\d{5}$/, 
																:message => "zip code should be 5 digits only"

		# Scopes
		scope :all, order(:zip)

	  # Callback
		before_save :find_location_coordinates

		# List of states for drop down menu
		STATES_LIST = [['Alabama', 'AL'],['Alaska', 'AK'],['Arizona', 'AZ'],['Arkansas', 'AR'],['California', 'CA'],['Colorado', 'CO'],['Connectict', 'CT'],['Delaware', 'DE'],['District of Columbia ', 'DC'],['Florida', 'FL'],['Georgia', 'GA'],['Hawaii', 'HI'],['Idaho', 'ID'],['Illinois', 'IL'],['Indiana', 'IN'],['Iowa', 'IA'],['Kansas', 'KS'],['Kentucky', 'KY'],['Louisiana', 'LA'],['Maine', 'ME'],['Maryland', 'MD'],['Massachusetts', 'MA'],['Michigan', 'MI'],['Minnesota', 'MN'],['Mississippi', 'MS'],['Missouri', 'MO'],['Montana', 'MT'],['Nebraska', 'NE'],['Nevada', 'NV'],['New Hampshire', 'NH'],['New Jersey', 'NJ'],['New Mexico', 'NM'],['New York', 'NY'],['North Carolina','NC'],['North Dakota', 'ND'],['Ohio', 'OH'],['Oklahoma', 'OK'],['Oregon', 'OR'],['Pennsylvania', 'PA'],['Rhode Island', 'RI'],['South Carolina', 'SC'],['South Dakota', 'SD'],['Tennessee', 'TN'],['Texas', 'TX'],['Utah', 'UT'],['Vermont', 'VT'],['Virginia', 'VA'],['Washington', 'WA'],['West Virginia', 'WV'],['Wisconsin ', 'WI'],['Wyoming', 'WY']]

	# Functions
	# Create a static map 
	def create_map_link
		locationMarker = "&markers=color:red%7Ccolor:red%7C#{latitude},#{longitude}"
		map = "http://maps.google.com/maps/api/staticmap?center=#{latitude},#{longitude}&zoom=15&size=350x350&maptype=roadmap#{locationMarker}&sensor=false"
	end

	private
	def find_location_coordinates
		coord = Geokit::Geocoders::GoogleGeocoder.geocode "#{street}, #{city}, #{state}, #{zip}"
		if coord.success
			self.latitude, self.longitude = coord.ll.split(',')
		else
			errors.add_to_base("Error with geocoding")
		end
	end

end
