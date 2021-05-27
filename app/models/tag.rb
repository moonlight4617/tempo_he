class Tag < ApplicationRecord
  has_many :tag_to_shops, dependent: :destroy
  has_many :shop, through: :tag_to_shops

  validates :name, presence: true
  validates :name, uniqueness: true
end
