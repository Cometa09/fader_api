class ConfigurationElement < ApplicationRecord
  enum element_type: { button: 0, fader: 1, knobs: 2, eq_slider: 3, group_fader: 4, display: 5, meter: 6 }, _prefix: true
  enum control_function: { volume: 0, pan: 1, eq: 2, send: 3 }, _prefix: true
  enum target_type: { channel: 0, group: 1, output: 2, global: 3 }, _prefix: true

  belongs_to :target, polymorphic: true, optional: true
  belongs_to :configuration, optional: true
end
