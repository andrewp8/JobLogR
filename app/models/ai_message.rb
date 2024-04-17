# == Schema Information
#
# Table name: ai_messages
#
#  id             :bigint           not null, primary key
#  body           :text             default([]), is an Array
#  role           :text             default([]), is an Array
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  job_listing_id :bigint           not null
#
# Indexes
#
#  index_ai_messages_on_job_listing_id  (job_listing_id)
#
# Foreign Keys
#
#  fk_rails_...  (job_listing_id => job_listings.id)
#
class AiMessage < ApplicationRecord
  belongs_to :job_listing, foreign_key: :job_listing_id

  def self.generate_response
    client = OpenAI::Client.new(access_token: ENV["OPENAI_API_KEY"])
    instructed_prompt = "As a career expert, please answer my question #{self.body[0]}. Give me a specific advices, insights, recommendations, url if necessary. If i ever ask about resume or cover letter, please provide important key to add in my resume or cover letter for the company if applicable. Please respond in Markdown syntax language. Please feel free to refuse answer questions which doesn't have anything to do with job search."
    response = client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: [{ role: "user", content: instructed_prompt }],
        temperature: 0.7,
      },
    )
    return response["choices"][0]["message"]["content"]
  end
end
