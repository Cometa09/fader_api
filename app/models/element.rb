class Element < ApplicationRecord

  has_many :buttons, class_name: 'Button', foreign_key: 'element_id'
  has_many :faders

  enum element_type: { button: 0, fader: 1, knobs: 2, eq_slider: 3, group_fader: 4, display: 5, meter: 6 }
  enum control_function: { volume: 0, pan: 1, eq: 2, send: 3 }, _prefix: true

  belongs_to :target, polymorphic: true, optional: true

  validates :x_position, :y_position, :width, :height, presence: true, numericality: { only_integer: true }
  validates :label, :element_type, :control_function, :target_type, presence: true
end
