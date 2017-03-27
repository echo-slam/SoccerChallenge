class Notification < ApplicationRecord
  belongs_to :notified_by, class_name: 'Player'
  belongs_to :player
end
