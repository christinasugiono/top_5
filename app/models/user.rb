class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  acts_as_favoritor
  has_many :boards, dependent: :destroy
  has_many :contributions, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  def karma_points
    contributions.extract_associated(:points).count
  end
end
