class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token
  
  before_save :downcase_email
  before_create :create_activation_digest
  
  has_secure_password
  
  has_many :messages
  has_many :chatrooms, through: :messages

  validates :username, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :email, 
            presence: true, uniqueness: { case_sensitive: false },
            length: { maximum: 255 },
            format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  
  # will_paginate per_page settings for this model
  self.per_page = 20

  # Returns the hash digest of the given password. For test fixture.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  # Returns a random token. For remember me feature.
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(self.remember_token))
  end
  
  def forget
    update_attribute(:remember_digest, nil)
  end
  
  # Check if User can be authenticated by token for specific attribute.
  # Returns true if the given token matches the digest.
  # e.g. 
  # user.authenticated?(:remember, remember_token)
  # user.authenticated?(:password, password)
  # user.authenticated?(:activation, activation_token)
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end
  
  def activate  
    update_attributes(activated: true, activated_at: Time.zone.now)  
  end
  
  def send_activation_mail
    UserMailer.account_activation(self).deliver_now
  end
  
  private
  
    def downcase_email
      self.email = email.downcase
    end

    def create_activation_digest
      self.activation_token = User.new_token
      self.activation_digest = User.digest(activation_token)
    end
end
