class PlayerResult < ApplicationRecord
  validates :goal, numericality: true
end
