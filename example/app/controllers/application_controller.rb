class ApplicationController < ActionController::Base

	before_filter :lookup_user_session, :require_user

	helper_method :current_user, :current_user_session, :logged_in?, :logged_out?, :require_user

	protect_from_forgery

private

	def lookup_user_session
		if request.session[:user_session_access_token]
			@current_user_session = UserSession.where(
				:access_token => request.session[:user_session_access_token],
				:user_agent   => request.user_agent
			).where('expires_at > ?', Time.now).first
			
			if @current_user_session
				@current_user_session.ip_address = request.remote_ip
				if @current_user_session.ip_address_changed?
					@current_user_session.location = Geokit::Geocoders::MultiGeocoder.geocode(request.remote_ip).full_address
				end
				@current_user_session.last_accessed_on = Time.now
				@current_user_session.save
			end
		else
			@current_user_session = nil
		end
	end

	def require_user
		redirect_to new_user_session_path, :notice => 'You have to be logged in, to access that page.' if logged_out?
	end

	def require_no_user
		redirect_to request.refferer
	end

	def current_user_session
		@current_user_session	
	end

	def current_user
		@current_user_session.try(:user)
	end

	def logged_out?
		@current_user_session.nil?
	end

	def logged_in?
		!@current_user_session.nil?
	end

end

