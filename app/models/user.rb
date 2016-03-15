class User < ActiveRecord::Base
  attr_accessor :remember_token
  # Valid email regex
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  # Relations
  has_many :posts, dependent: :destroy

  before_save {
    self.email = email.downcase
  }
  # Name
  validates :name,
    presence: true,
    length: {minimum: 2, maximum: 50}
  # Email
  validates :email,
    presence: true,
    uniqueness: {case_sensitive: false},
    length: {maximum: 255},
    format: {with: VALID_EMAIL_REGEX}
  # Password
  has_secure_password
  validates :password,
    presence: true,
    length: {minimum: 6},
    allow_nil: true

  # About
  validates :about,
    length: {maximum: 200},
    allow_nil: true


  # Return the hash digest of the given string
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ?
      BCrypt::Engine::MIN_COST :
      BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Return random token
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Remember user
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Return true if the given token matches the digest
  def authenticated? remember_token
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Forget user
  def forget
    update_attribute :remember_digest, nil
  end




end
