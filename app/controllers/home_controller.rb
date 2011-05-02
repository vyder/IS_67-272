class HomeController < ApplicationController
  def index
		if logged_in?
			@parties = Party.for_host(current_host.id).upcoming.paginate :page => params[:page], :per_page => 12
			@current_host = current_host
		end
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
