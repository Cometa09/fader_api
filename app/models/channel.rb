class Channel < ApplicationRecord
  has_many :elements, as: :target, dependent: :nullify
end