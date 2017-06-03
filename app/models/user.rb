class User < ApplicationRecord
  has_secure_password

  has_many :user_rooms
  has_many :rooms, through: :user_rooms

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end
