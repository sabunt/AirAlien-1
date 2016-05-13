class AddGuestIdToFeedbacks < ActiveRecord::Migration
  def change
  	add_column :feedbacks, :guest_id, :integer
  end
end
