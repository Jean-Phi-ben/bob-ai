class AiController < ApplicationController
  def assist
    client = OpenAI::Client.new(access_token: ENV["OPENAI_API_KEY"])

    response = client.chat(
      parameters: {
        model: "gpt-4o-mini",
        messages: [
          { role: "system", content: "Tu aides l’utilisateur à préparer un projet de bricolage. Donne des conseils simples, courts, utiles." },
          { role: "user", content: params[:prompt] }
        ]
      }
    )

    ai_output = response.dig("choices", 0, "message", "content") || "Je n’ai pas compris."

    render json: { reply: ai_output }
  end
end
