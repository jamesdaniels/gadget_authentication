class UserSession < ActiveRecord::Base

	set_primary_key :access_token

	before_create :intialize_access_token, :initialize_expires_at, :initialize_request_data

	belongs_to :user

	attr_accessor :login, :password, :request

	before_validation :find_user

	validates :login,    :presence => true, :on => :create
	validates :password, :presence => true, :password_match => true, :on => :create

	def expired?
		expires_at < Time.now
	end

private

	def find_user
		self.user ||= User.where(:login => login.downcase).first
		unless self.user
			self.errors[:login] << "can't be found"
		end
	end

	def intialize_access_token
		self.access_token = UUIDTools::UUID.random_create().to_s
	end

	def initialize_expires_at
		self.expires_at = 2.weeks.from_now
	end

	def initialize_request_data
		self.user_agent = request.user_agent
		self.ip_address = request.remote_ip
		self.location = Geokit::Geocoders::MultiGeocoder.geocode(request.remote_ip).full_address
	end

end
