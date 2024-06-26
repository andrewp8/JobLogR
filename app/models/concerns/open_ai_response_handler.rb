# app/models/concerns/open_ai_response_handler.rb
module OpenAiResponseHandler
  extend ActiveSupport::Concern


  class_methods do
    def process_openai_response(user_query)
      client = OpenAI::Client.new(access_token: ENV["OPENAI_API_KEY"])
      instructed_prompt = "As a career expert, please answer my question #{user_query}. Give me a specific advices, insights, recommendations, url if necessary. If i ever ask about resume or cover letter, please provide important key to add in my resume or cover letter for the company if applicable. Please respond in Markdown syntax language. Please feel free to refuse answer questions which doesn't have anything to do with job search."
      response = client.chat(
        parameters: {
          model: "gpt-3.5-turbo",
          messages: [{ role: "user", content: instructed_prompt }],
          temperature: 0.7,
        },
      )
      return response["choices"][0]["message"]["content"]
    rescue StandardError => e
      Rails.logger.error "Failed to generate response from OpenAI: #{e.message}"
      "Error generating response. Please try again."
    end
  end
end
