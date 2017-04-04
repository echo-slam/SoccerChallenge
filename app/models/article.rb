class Article < ApplicationRecord
  belongs_to :player
  validates :title, presence: true
  validates :body, presence: true
end
