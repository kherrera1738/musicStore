class WinningBid < ApplicationRecord
  belongs_to :instrument
  belongs_to :user
end
