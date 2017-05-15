class User < ApplicationRecord
  has_many :user_rooms, class_name: 'UserRoom'
  has_many :rooms, through: :user_rooms

  validates :name, presence: true
  validates :email, presence: true
end
