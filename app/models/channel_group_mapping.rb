class ChannelGroupMapping < ApplicationRecord
  belongs_to :channel
  belongs_to :group
end
