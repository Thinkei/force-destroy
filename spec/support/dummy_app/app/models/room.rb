class Room < ApplicationRecord
  has_many :seats, dependent: :destroy
  has_many :tickets, through: :seats
end
