class User < ActiveRecord::Base

	has_secure_password	

	before_validation :normalize_attributes

	has_many :user_sessions,            :dependent => :destroy
	has_many :user_email_confirmations, :dependent => :destroy

	validates :login, :presence => true, :uniqueness => true
	validates :email, :presence => true, :uniqueness => true, :email_format => true

	state_machine :state, :initial => :pending do

		event :confirm do
			transition :pending => :confirmed, :invited => :confirmed
		end

		event :deactivate do
			transition :confirmed => :deactivated
		end

		state :invited
		state :pending
		state :confirmed
		state :deactivated

	end

private

	def normalize_attributes
		self.login = login.downcase if login
		self.email = email.downcase if email
	end

end
