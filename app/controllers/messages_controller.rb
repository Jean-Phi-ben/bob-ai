class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project

  def index
    @messages = @project.messages.order(:created_at)
    puts @messages
    #@messages.user = current_user
  end


  def create
    @message = @project.messages.build(message_params.merge(role: "user"))

    if @message.save
      client = OpenAI::Client.new(access_token: ENV["OPENAI_API_KEY"])


      response = client.chat(
        parameters: {
          model: "gpt-4o-mini",
          messages: build_conversation_messages
        }
      )

      ai_output = response.dig("choices", 0, "message", "content") || "Je n'ai pas réussi à répondre."

      @project.messages.create!(
        content: ai_output,
        role: "assistant"
      )

      redirect_to project_messages_path(@project)
    else
      @messages = @project.messages.order(:created_at)
      render :index, status: :unprocessable_entity
    end
  end


  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def message_params
    params.require(:message).permit(:content)
  end

  def build_conversation_messages
    history = @project.messages.order(:created_at).map do |msg|
      {
        role: msg.role == "ai" ? "assistant" : "user",
        content: msg.content
      }
    end

    history << { role: "user", content: @message.content }

    [
      { role: "system", content: "Tu es un assistant qui aide l'utilisateur sur son projet de bricolage / travaux." }
    ] + history
  end
end

















# class MessagesController < ApplicationController
#   def index
#     @project = current_user.projects.find(params[:project_id])
#     @message = Message.new
#     @messages = @project.messages.order(:created_at)
#   end

#   def create
#     @message = Message.new(message_params)
#     @message.user = current_user
#     @message.save
#     redirect_to messages_path
#   end

#   private

#   def message_params
#     params.require(:message).permit(:content)
#   end
# end
