class Instrument < ApplicationRecord
  before_destroy :not_referenced_by_any_line_item
  belongs_to :user, optional: true
  has_many :line_items, dependent: :destroy
  has_many :bids, dependent: :destroy
  has_many :watched_items, dependent: :destroy

  # mount_uploader :image, ImageUploader
  # serialize :image, JSON # If you use SQLite, add this line

  has_one_attached :image

  validates :title, :brand, :price, :model, presence: true
  validates :description, length: { maximum: 1000, too_long: "%{count} characters is the maximum aloud. "}
  validates :title, length: { maximum: 140, too_long: "%{count} characters is the maximum aloud. "}
  validates :price, length: { maximum: 7 }

  BRAND = %w{ Fender Gibson Epiphone ESP Martin Dean Taylor Jackson PRS  Ibanez Charvel Washburn }
  FINISH = %w{ Black White Navy Blue Red Clear Satin Yellow Seafoam }
  CONDITION = %w{ New Excellent Mint Used Fair Poor }

  def max_bid
    if !bids.empty?
      bids.max { |a, b| a.price <=> b.price }.price
    else
      0
    end
  end

  def display_thumb
    image.variant(resize_to_limit: [400, 300])
  end

  def display_default
    image.variant(resize_to_limit: [800, 600])
  end

  private

    def not_referenced_by_any_line_item
      unless line_items.empty?
        errors.add(:base, "Line items present")
        throw :abort
      end
    end

end
