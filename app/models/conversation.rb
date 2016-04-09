class Conversation < ActiveRecord::Base
	# attributes: sender_id, recipient_id
	belongs_to :sender, foreign_key: :sender_id, class_name: "User"
	belongs_to :recipient, foreign_key: :recipient_id, class_name: "User"

	has_many :messages, dependent: :destroy

	validates :sender_id, uniqueness: { scope: :recipient_id }

	scope :involving, -> (user) do
		where("conversations.sender_id = ? OR conversations.recipient_id = ?", user.id, user.id)
	end

	scope :between, -> (sender_id, recipient_id) do
		where("(conversations.sender_id = ? AND conversations.recipient_id = ?) OR (conversations.sender_id = ? AND conversations.recipient_id = ?)",
			sender_id, recipient_id, recipient_id, sender_id)
	end

	def find_other_user(current_user)
		if current_user == self.sender
			other_user = self.recipient
		else
			other_user = self.sender
		end
		
		other_user
	end




end
