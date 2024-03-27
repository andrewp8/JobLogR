# == Schema Information
#
# Table name: interviews
#
#  id             :bigint           not null, primary key
#  details        :text
#  end_date       :date
#  interview_type :string           not null
#  point          :integer          default(1), not null
#  start_date     :date
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  job_listing_id :bigint           not null
#
# Indexes
#
#  index_interviews_on_job_listing_id  (job_listing_id)
#
# Foreign Keys
#
#  fk_rails_...  (job_listing_id => job_listings.id)
#
class Interview < ApplicationRecord
  belongs_to :job_listing

  after_create :increment_job_listing_total_points

  private

  def increment_job_listing_total_points
    job_listing.increment!(:total_points, point)
  end
end
