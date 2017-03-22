class Field < ApplicationRecord
  belongs_to :field_owner
  belongs_to :venue
end
