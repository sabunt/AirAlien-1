class ReviewsController < ApplicationController

	def create
		@review = current_user.reviews.create!(review_params)
		redirect_to room_path(@review.room)
	end
	
	def destroy
		review = Review.find(params[:id])
		room = review.room
		review.destroy

		redirect_to room_path(room)
	end

	private
		def review_params
			params.require(:review).permit(:comment, :star, :room_id)
		end
end
