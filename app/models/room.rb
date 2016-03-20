class Room < ActiveRecord::Base
  belongs_to :user

  validates :home_type, presence: true
  validates :room_type, presence: true
  validates :accomodate, presence: true
  validates :bedroom, presence: true
  validates :bathroom, presence: true
  validates :listing_name, presence: true, length: { maximum: 50 }
  validates :summary, presence: true, length: { maximum: 50 }
  validates :address, presence: true
  validates :price, presence: true
end
