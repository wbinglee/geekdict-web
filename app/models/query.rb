class Query < ActiveRecord::Base
	attr_accessor :apikey

	belongs_to :user
	validates :query, presence: true

end
