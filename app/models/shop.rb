class Shop < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :owner
  has_many :calendars
  has_many :chats, foreign_key: :shop_id, dependent: :destroy
  has_many :availables, foreign_key: :shop_id
  validates :name, presence: true, length: { maximum: 50 }
  validates :zip_code, presence: true
  validates :prefecture, presence: true
  validates :city, presence: true
  validates :tel, presence: true
  validates :station, presence: true
end
