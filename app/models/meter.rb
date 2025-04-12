class Meter < ApplicationRecord
  belongs_to :element

  validates :meter_type, presence: true, inclusion: { in: %w[Peak VU] }
  validates :current_level, :peak_level, numericality: { only_integer: true }
end
