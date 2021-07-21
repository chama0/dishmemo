class Comment < ApplicationRecord
  belongs_to :dish
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :dish_id, presence: true
  validates :content, presence: true, length: { maximum: 50 }
end
