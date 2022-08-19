class BoardHashtag < ApplicationRecord
  belongs_to :board
  belongs_to :hashtag
end
