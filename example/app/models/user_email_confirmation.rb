class UserEmailConfirmation < ActiveRecord::Base

	set_primary_key :confirmation_token

	belongs_to :user

	before_create :initialize_confirmation_token

	state_machine :state, :initial => :pending do

		event :confirm do
			transition :pending => :confirmed
		end

		state :confirmed

	end

private

	def initialize_confirmation_token
		self.confirmation_token = UUIDTools::UUID.random_create().to_s
	end

end
