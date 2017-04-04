require "#{Rails.root}/app/services/fetch_page.rb"

class Article < ApplicationRecord
  belongs_to :player
  validates :title, presence: true
  validates :image_url, presence: true
  validates :body, presence: true

  def self.seed_article
    fetch_obj = FetchPage.new()
    data_fetch = fetch_obj.fetch_webpage
  end
end
