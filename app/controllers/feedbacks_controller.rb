class FeedbacksController < ApplicationController
	before_action :authenticate_user!

	def create
		guest = User.find(params[:feedback][:guest_id])
		
		if !guest.feedback_exists?(current_user)
			feedback = current_user.feedbacks.create!(feedback_params)	
		end
		
		redirect_to user_path(guest.id)
	end

	private
		def feedback_params
			params.require(:feedback).permit(:comment, :reservation_id, :guest_id)
		end
end
