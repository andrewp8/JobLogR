# == Schema Information
#
# Table name: job_listings
#
#  id              :bigint           not null, primary key
#  company         :string           not null
#  details         :text
#  details_summary :string
#  job_url         :string
#  location        :string
#  portal_url      :string
#  salary          :float
#  status          :integer          default("pending"), not null
#  title           :string           not null
#  total_points    :integer          default(0), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  board_id        :bigint           not null
#
# Indexes
#
#  index_job_listings_on_board_id  (board_id)
#
# Foreign Keys
#
#  fk_rails_...  (board_id => boards.id)
#
class JobListing < ApplicationRecord
  enum status: {
    pending: 0,
    under_review: 1,
    interviewing: 2,
    rejected: -1,
  }
  
  belongs_to :board
  has_many :interviews, dependent: :destroy
  has_many :ai_messages, foreign_key: :job_listing_id

  has_many_attached :attachments, service: :amazon

  validates :title, presence: true
  validates :company, presence: true
  validates :job_url, format: { with: /\Ahttps?:\/\//, message: "must start with http:// or https://" }, allow_blank: true
  validate :attachments_content_type

  def self.follow_up_email_template
    follow_up_template = "Hello,<br><br>
    I hope this email finds you well.<br><br>
    My name is [Your Name] and I am following up on my application for the [Job Title] position that I submitted on [Date].<br><br>
    I am very interested in this opportunity at [Company Name] because [ Briefly mention a reason why you're interested in the company and role (e.g., company's mission aligns with your values, specific aspect of the job description excites you)].<br><br>
    In my previous role at [Previous Company], I [ Briefly mention a relevant accomplishment or skill that aligns with the job requirements]. I am confident that my skills and experience would be a valuable asset to your team.<br><br>
    I understand the hiring process takes time, but I wanted to reiterate my strong interest in this position.<br><br>
    Thank you for your time and consideration.<br><br>
    Sincerely,<br><br>
    [Your Name]
    "
  end
  private

  def attachments_content_type
    attachments.each do |attachment|
      if !attachment.content_type.in?(%w(application/pdf))
        errors.add(:attachments, "must be a PDF file")
      end
    end
  end
end
