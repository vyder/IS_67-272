class HomeController < ApplicationController
  def index
		#@parties = Party.group("name").order("party_date", "start_time").paginate :page => params[:page], :per_page => 12
		@current_host = current_host
  end

	def about
	end

	def contact
	end

	def privacy
	end

	def credits
	end	
end
