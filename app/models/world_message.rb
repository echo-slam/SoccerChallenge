class WorldMessage < ApplicationRecord
  validates :body, presence: true
end
