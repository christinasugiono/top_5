class Board < ApplicationRecord
  belongs_to :user
  has_many :board_hashtags
  has_many :hashtags, through: :board_hashtags
  has_many :contributions

  validates :title, :description, presence: true
end
