class CreateUserSessions < ActiveRecord::Migration
	def change
		create_table :user_sessions, :id => false do |t|
			t.references :user
			t.string     :access_token, :limit => 36, :primary => true
			t.datetime   :expires_at
			t.timestamps
		end
	end
end
