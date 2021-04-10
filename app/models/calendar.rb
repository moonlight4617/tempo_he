class Calendar < ApplicationRecord
  belongs_to :shop
  belongs_to :user
  validates :rent_date, presence: true
end
