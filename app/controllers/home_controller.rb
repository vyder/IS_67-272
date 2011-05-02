class HomeController < ApplicationController
  def index
		@parties = Party.upcoming.paginate :page => params[:page], :per_page => 12
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
