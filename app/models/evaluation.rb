class Evaluation < ApplicationRecord
  belongs_to :user
  belongs_to :shop
  validates_uniqueness_of :user_id, scope: [:shop_id, :toshop]
end
