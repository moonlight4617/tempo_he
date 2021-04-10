class Owner < ApplicationRecord
  attr_accessor :remember_token
  has_many :shops, dependent: :destroy
  has_secure_password
  before_save { email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },  format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false}
  validates :password, presence: true, length: {minimum: 6}, allow_nil: true

  def Owner.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def Owner.new_token
    SecureRandom.urlsafe_base64
  end

  def save_owner_remember_digest
    self.remember_token = Owner.new_token
    update_attribute(:remember_digest, Owner.digest(remember_token))
  end

  def authenticated?(remember_token)
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget_owner_remember_digest
    update_attribute(:remember_digest, nil)
  end
end
