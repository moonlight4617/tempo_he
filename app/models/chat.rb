class Chat < ApplicationRecord
  belongs_to :shop
  belongs_to :user
  has_many :messages, foreign_key: :chat_id, dependent: :destroy
end
