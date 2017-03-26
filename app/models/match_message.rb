class MatchMessage < ApplicationRecord
  belongs_to :match
  validates :body, presence: true
end
