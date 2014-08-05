class Query < ActiveRecord::Base
	attr_accessor :apikey

	belongs_to :user
	validates :query, presence: true

	before_save :lookup_user

	def lookup_user
		user = User.find_by_api_key apikey
		logger.debug "The user is : #{user.id}"
		self.user_id = user.id
	end
end
