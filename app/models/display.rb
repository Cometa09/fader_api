class Display < ApplicationRecord
  belongs_to :element

  validates :display_type, presence: true, inclusion: { in: %w[text number] }
  validates :value, numericality: { only_integer: true }
end
