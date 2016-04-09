class MessagesController < ApplicationController
	before_action :authenticate_user!
	before_action :set_conversation

	def index
		@message = @conversation.messages.new
		
		sender = @conversation.sender
		recipient = @conversation.recipient
		if current_user == sender || current_user == recipient
			@other_user = @conversation.find_other_user(current_user)
			@messages = @conversation.messages.order(created_at: :desc)
		else
			redirect_to convesations_path, alert: "You don't have permission to view this conversation."
		end
	end

	def create
		@message = @conversation.messages.new(message_params)
		# @messages = @conversation.messages.order("created_at DESC") I don't think I need this code...

		if @message.save
			redirect_to conversation_messages_path(@conversation), notice: "Message sent!"
		else
			redirect_to conversation_messages_path(@conversation), alert: "Message could not be sent."
		end
	end

	private
		def set_conversation
			@conversation = Conversation.find(params[:conversation_id])
		end

		def message_params
			params.require(:message).permit(:content, :user_id)
		end


end
