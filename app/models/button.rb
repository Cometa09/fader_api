class Button < ApplicationRecord
  belongs_to :element
  
  validates :status, inclusion: { in: ['ON', 'OFF'] }
end
