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
  # nice concern!
  include OpenAiResponseHandler
  belongs_to :job_listing, foreign_key: :job_listing_id
end
