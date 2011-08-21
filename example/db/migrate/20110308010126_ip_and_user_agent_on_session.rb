class IpAndUserAgentOnSession < ActiveRecord::Migration
	def change
		add_column :user_sessions, :ip_address,       :string
		add_column :user_sessions, :user_agent,       :string
		add_column :user_sessions, :location,         :string
		add_column :user_sessions, :last_accessed_on, :datetime
	end
end
