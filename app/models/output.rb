class Output < ApplicationRecord
  has_many :elements, as: :target, dependent: :nullify
  validates :label, presence: true
end