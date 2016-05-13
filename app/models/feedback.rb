class Feedback < ActiveRecord::Base
  #attributes for comments, user_id, reservation_id, guest_id

  belongs_to :user
  belongs_to :reservation


end
