# == Schema Information
#
# Table name: job_listings
#
#  id              :bigint           not null, primary key
#  company         :string
#  details         :text
#  details_summary :string
#  location        :string
#  points          :integer          default(0), not null
#  salary          :float
#  status          :integer          default("pending"), not null
#  title           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  applicant_id    :bigint           not null
#  board_id        :bigint           not null
#
# Indexes
#
#  index_job_listings_on_applicant_id  (applicant_id)
#  index_job_listings_on_board_id      (board_id)
#
# Foreign Keys
#
#  fk_rails_...  (applicant_id => users.id)
#  fk_rails_...  (board_id => boards.id)
#
class JobListing < ApplicationRecord
  belongs_to :applicant, class_name: "User"
  belongs_to :board

  enum status: {
    pending: 0,
    under_review: 1,
    interviewing: 2,
    rejected: -1
  }
end