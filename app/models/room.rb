class Room < ActiveRecord::Base
  belongs_to :user
  has_many :photos, dependent: :destroy
  has_many :reservations, dependent: :destroy

  validates :photos, presence: true
  validates :home_type, presence: true
  validates :room_type, presence: true
  validates :accomodate, presence: true
  validates :bedroom, presence: true
  validates :bathroom, presence: true
  validates :listing_name, presence: true, length: { maximum: 50 }
  validates :summary, presence: true, length: { maximum: 50 }
  validates :address, presence: true
  validates :price, presence: true, numericality: { only_integer: true, greater_than: 0 }

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

end
