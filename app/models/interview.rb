# == Schema Information
#
# Table name: interviews
#
#  id             :bigint           not null, primary key
#  details        :text
#  end_date       :datetime
#  interview_type :string           not null
#  point          :integer          default(1), not null
#  start_date     :datetime
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
  validate :start_date_and_end_date_cannot_be_in_the_past, :start_date_cannot_be_before_or_equal_end_date
  private

  def increment_job_listing_total_points
    job_listing.increment!(:total_points, point)
  end

  def start_date_and_end_date_cannot_be_in_the_past
    if start_date.present? && start_date < Time.current
      errors.add(:start_date, "can't be in the past")
    end
    if end_date.present? && end_date < Time.current
      errors.add(:end_date, "can't be in the past")
    end
  end

  def start_date_cannot_be_before_or_equal_end_date
    if start_date.present? && end_date.present? && end_date < start_date
      errors.add(:end_date, "can't be before start date")
    end
    if start_date.present? && end_date.present? && end_date == start_date
      errors.add(:end_date, "can't be the same with start date")
    end
  end
end
