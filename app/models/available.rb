class Available < ApplicationRecord
  belongs_to :shop
  validates :start_time, uniqueness: { scope: :rent_date }
end
