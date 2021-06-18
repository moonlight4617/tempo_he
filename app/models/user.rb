class User < ApplicationRecord
  attr_accessor :remember_token
  has_secure_password
  mount_uploader :image, ImageUploader
  has_many :calendars
  has_many :chats, foreign_key: :user_id, dependent: :destroy
  has_many :evaluations, foreign_key: :user_id, dependent: :destroy
  has_many :favorites, foreign_key: :user_id, dependent: :destroy
  include PublicUid::ModelConcern
  before_save { email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },  format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false}
  validates :password, presence: true, length: {minimum: 6}, allow_nil: true

  def to_param
    public_uid
  end

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def save_remember_digest
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget_remember_digest
    update_attribute(:remember_digest, nil)
  end

  def liked_by?(shop_id)
    favorites.pluck(:shop_id).include?(shop_id)
  end

end
