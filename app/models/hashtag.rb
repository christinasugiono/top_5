class Hashtag < ApplicationRecord
  has_many :board_hashtags
  has_many :boards, through: :board_hashtags

  validates :title, presence: true
end
