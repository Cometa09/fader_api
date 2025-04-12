class EqSlider < ApplicationRecord
  belongs_to :element

  enum frequency_band: { low: 0, mid: 1, high: 2 }
end
