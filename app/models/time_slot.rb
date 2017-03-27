class TimeSlot < ApplicationRecord
  belongs_to :match
  belongs_to :field
end
