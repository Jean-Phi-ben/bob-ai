class MessagesController < ApplicationController
  def index
    @project = current_user.projects.find(params[:project_id])
    @message = Message.new
    @messages = @project.messages.order(:created_at)
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
