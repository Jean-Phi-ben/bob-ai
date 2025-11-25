class MessagesController < ApplicationController
  def index
    @messages = Message.all.order(:created_at)
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    @message.user = current_user
    @message.save
    redirect_to messages_path
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
