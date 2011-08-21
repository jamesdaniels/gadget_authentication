class PasswordMatchValidator < ActiveModel::EachValidator
	def validate_each(record, attribute, value)
		if record.user
			record.errors[attribute] << (options[:message] || 'does not match records') unless record.user.authenticate(value)
		end
	end
end
