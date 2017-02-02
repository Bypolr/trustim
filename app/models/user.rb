class User < ApplicationRecord
	before_save { self.email = email.downcase }
	has_many :messages
	has_many :chatrooms, through: :messages

	validates :username, presence: true, uniqueness: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, uniqueness: { case_sensitive: false },
	                  length: { maximum: 255 },
	                  format: { with: VALID_EMAIL_REGEX }
	validates :password, presence: true, length: { minimum: 6 }

	has_secure_password
end
