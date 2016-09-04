class Seat < ApplicationRecord
  has_one :ticket, dependent: :destroy
  belongs_to :room
end
