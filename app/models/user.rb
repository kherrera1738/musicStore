class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :instruments
  has_many :bids
  has_many :watched_items, dependent: :destroy
  has_many :winning_bids, dependent: :destroy

  def is_part_of_watchlist?(instrument_id)
    !watched_items.empty? and watched_items.where(instrument_id: instrument_id).exists?
  end

  def get_watched_item(instrument_id)
    watched_items.find_by(instrument_id: instrument_id)    
  end
end
