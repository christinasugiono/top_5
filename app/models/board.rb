class Board < ApplicationRecord
  belongs_to :user
  has_many :board_hashtags
  has_many :hashtags, through: :board_hashtags
  has_many :contributions
  acts_as_favoritable

  validates :title, :description, presence: true

  include PgSearch::Model
    pg_search_scope :global_search,
    against: [ :title, :description ],
    associated_against: {
      hashtags: [ :title ],
      contributions: [ :name ]
    },
    using: {
      tsearch: { prefix: true }
    }
end
