class User < ActiveRecord::Base
	attr_accessor :password
	validates :email, format: { with: /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/, 
                              message: "%{value} is not a valid email" }, uniqueness: true
  
	validates :password, presence: true
	validates_length_of :password, :in => 6..20, :on => :create

	before_save :encrypt_password
	after_save :clear_password
	def encrypt_password
		if password.present?
		self.salt = BCrypt::Engine.generate_salt
		self.encrypted_password= BCrypt::Engine.hash_secret(password, salt)
		end
	end
	def clear_password
	  	self.password = nil
	end

	def self.authenticate(email, password)
	    user = find_by_email(email)
	    if user && user.encrypted_password == BCrypt::Engine.hash_secret(password, user.salt)
	      user
	    else
	      nil
	    end
  	end

end