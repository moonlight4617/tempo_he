class Shop < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :owner
  has_many :calendars
  has_many :chats, foreign_key: :shop_id, dependent: :destroy
  has_many :availables, foreign_key: :shop_id, dependent: :destroy
  has_many :tag_to_shops, foreign_key: :shop_id, dependent: :destroy

  # 関連付いている中間テーブルのtag_to_shopsも同時に更新
  accepts_nested_attributes_for :tag_to_shops
  has_many :tags, through: :tag_to_shops
  validates :name, presence: true, length: { maximum: 50 }
  validates :zip_code, presence: true
  validates :prefecture, presence: true
  validates :city, presence: true
  validates :tel, presence: true
  validates :station, presence: true  
end
