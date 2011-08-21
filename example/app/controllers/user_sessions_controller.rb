class UserSessionsController < ApplicationController

	skip_before_filter :require_user, :only => [:new, :create]

	# GET /user_sessions
	# GET /user_sessions.xml
	def index
		@user_sessions = current_user.user_sessions
	end

	# GET /user_sessions/new
	# GET /user_sessions/new.xml
	def new
		@user_session = UserSession.new
	end

	# POST /user_sessions
	# POST /user_sessions.xml
	def create
		@user_session = UserSession.new(params[:user_session])
		@user_session.request = request

		if @user_session.save
			request.session[:user_session_access_token] = @user_session.access_token
			redirect_to(@user_session, :notice => 'User session was successfully created.')
		else
			render :action => "new"
		end
	end

	# DELETE /user_sessions/1
	# DELETE /user_sessions/1.xml
	def destroy
		@user_session = current_user.user_sessions.find(params[:id])
		@user_session.update_attribute(:expires_at, Time.now)

		if @user_session == current_user_session
			redirect_to new_user_session_path, :notice => 'Thanks for visiting.'
		else
			redirect_to user_sessions_path
		end
	end
end
