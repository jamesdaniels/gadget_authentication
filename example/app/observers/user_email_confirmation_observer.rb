class UserEmailConfirmationObserver < ActiveRecord::Observer

	observe :user_email_confirmation

	def before_confirm(user_email_confirmation, transition)
		user_email_confirmation.user.confirm!
	end

end
