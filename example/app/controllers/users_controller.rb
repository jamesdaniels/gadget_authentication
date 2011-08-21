class UsersController < ApplicationController

	skip_before_filter :require_user, :only => [:new, :create]

	# GET /users
	# GET /users.xml
	def index
		@users = User.all
	end

	# GET /users/1
	# GET /users/1.xml
	def show
		@user = User.find(params[:id])
	end

	# GET /users/new
	# GET /users/new.xml
	def new
		@user = User.new
	end

	# GET /users/1/edit
	def edit
		@user = User.find(params[:id])
	end

	# POST /users
	# POST /users.xml
	def create
		@user = User.new(params[:user])
		current_user_session = UserSession.new(:login => params[:user][:login], :password => params[:user][:password])
		current_user_session.request = request

		if @user.save
			if logged_out?
				current_user_session.save!
				request.session[:user_session_access_token] = current_user_session.access_token
			end
			redirect_to @user, :notice => 'User was successfully created.'
		else
			render :action => "new"
		end
	end

	# PUT /users/1
	# PUT /users/1.xml
	def update
		@user = User.find(params[:id])

		if @user.update_attributes(params[:user])
			redirect_to @user, :notice => 'User was successfully updated.'
		else
			render :action => "edit"
		end
	end

	# DELETE /users/1
	# DELETE /users/1.xml
	def destroy
		@user = User.find(params[:id])
		@user.destroy

		redirect_to(users_url)
	end
end
