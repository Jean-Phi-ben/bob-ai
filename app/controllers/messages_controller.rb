class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project

  def index
    @messages = @project.messages.order(:created_at)
    # puts @messages
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
      if ai_output.start_with?("```json")
        ai_output.gsub!("```json", "").gsub!("```", "")
      end
      parsed_response = JSON.parse(ai_output)

      @project.update(
        tools: parsed_response["tools"],
        materials: parsed_response["materials"],
        methodology: parsed_response["methodology"],
      )

      @project.messages.create!(
        content: parsed_response["message"],
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
        role: msg.role == "assistant" ? "assistant" : "user",
        content: msg.content
      }
    end

    history << { role: "user", content: @message.content }

    [
      {
        role: "system",
        content: "You are an assistant who helps the user with their DIY or renovation project.
          Before providing a solution, always begin by asking a first question about the type of materials they want to use,
          and a second question about the tools they have available. Then provide the methodology,
          unless the user has already provided everything you need.
          Your questions must be concrete, useful, and directly related to the project.
          If the request is incomplete or ambiguous, always start by asking for clarification.
          Finish in no more than 5 steps.

          # ANSWER FORMAT
          Answer format should always be a JSON with the following keys :
          - tools with the list of tools in markdown syntaxe - do not use an array,
          - materials with the list of materials in markdown syntaxe - do not use an array,
          - methodology with the whole methodology in markdown syntaxe - do not use an array,
          - message with the whole message that can be displayed in the chatroom with our user.
          Be consistent in the json."
      }
    ] + history + [ { role: "system", content: "# ANSWER FORMAT
          Answer format should always be a JSON with the following keys :
          - tools with the list of tools in markdown syntaxe - do not use an array,
          - materials with the list of materials in markdown syntaxe - do not use an array,
          - methodology with the whole methodology in markdown syntaxe - do not use an array,
          - message with the whole message that can be displayed in the chatroom with our user.
          Be consistent in the json."}]
  end
end

# Retourner un fichier JSON avec 4 clés = messages, tools, materials et methodo.
