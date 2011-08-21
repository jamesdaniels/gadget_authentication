class UserEmailConfirmationsController < ApplicationController

	# GET /user_email_confirmations/1
	# GET /user_email_confirmations/1.xml
	def show
		@user_email_confirmation = UserEmailConfirmation.find(params[:id])
	end

	# PUT /user_email_confirmations/1
	# PUT /user_email_confirmations/1.xml
	def update
		@user_email_confirmation = UserEmailConfirmation.find(params[:id])

		if @user_email_confirmation.update_attributes(params[:user_email_confirmation])
			redirect_to @user_email_confirmation, :notice => 'Account has been confirmed.'
		else
			render :action => "edit"
		end
	end

end
