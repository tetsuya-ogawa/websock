class User < ApplicationRecord
  has_secure_password

  has_many :user_rooms
  has_many :rooms, through: :user_rooms
  has_many :messages

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  def create_my_room
     user_rooms.create(room: Room.create(name: name))
  end
end
