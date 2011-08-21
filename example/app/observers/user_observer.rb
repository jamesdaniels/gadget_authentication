class UserObserver < ActiveRecord::Observer

	observe :user

	def after_create(user)
		UserEmailConfirmation.create!(:user => user, :email => user.email)
	end

end
