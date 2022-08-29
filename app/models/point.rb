class Point < ApplicationRecord
  belongs_to :user
  belongs_to :contribution

  validates :contribution_id, uniqueness: { scope: :user_id }
end
