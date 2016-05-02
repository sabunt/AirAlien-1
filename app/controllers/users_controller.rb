class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
		@rooms = @user.rooms

		reservations = @user.reservations
		reservations_with_host = []
		reservations.each do |reservation|
			if current_user && current_user.rooms.include?(reservation.room)
				reservations_with_host << reservation
			end
		end

		@reservation = reservations_with_host.first
		@feedback = Feedback.new
		@guest_feedbacks = @user.feedbacks_for_me
	end
end