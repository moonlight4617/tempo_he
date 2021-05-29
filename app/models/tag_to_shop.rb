class TagToShop < ApplicationRecord
  belongs_to :tag
  belongs_to :shop
  validates :tag_id, :uniqueness => { :scope => :shop_id }
end
