class PresetSetting < ApplicationRecord
  belongs_to :preset
  belongs_to :element
end
