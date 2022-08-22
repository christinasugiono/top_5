class Contribution < ApplicationRecord
  belongs_to :board
  belongs_to :user
  has_many :points

  validates :name, :description, presence: true
end
