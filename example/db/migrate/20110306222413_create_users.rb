class CreateUsers < ActiveRecord::Migration
	def change
		create_table :users do |t|
			t.string :login, :email, :password_digest, :state
			t.timestamps
		end
	end
end
