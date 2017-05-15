class Room < ApplicationRecord
  has_many :user_rooms, class_name: 'UserRoom'
  has_many :users, through: :user_rooms
  has_many :messages

  validates :name, presence: true
end
