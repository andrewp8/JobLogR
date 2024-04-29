# app/services/application_insights_service.rb
class ApplicationInsightsService
  attr_reader :current_user
  attr_reader :job_listings

  def initialize(job_listings, current_user)
    @current_user = current_user
    @job_listings =job_listings
  end

  def call

    follow_up_list = job_listings.where("job_listings.total_points < 1 AND job_listings.created_at >= ?", 6.months.ago)
    six_months_progress = job_listings.where("job_listings.created_at <= ?", 6.months.ago).count.presence || 0
    num_of_interviews_in_six_months = job_listings.where(status: :interviewing).where("job_listings.created_at <= ?", 6.months.ago).count.presence || 0
    last_seven_days_progress = job_listings.where("job_listings.created_at >= ?", 7.days.ago)
    total_interviewings = job_listings.where(status: :interviewing).count
    total_under_reviews = job_listings.where(status: :under_review).count
    total_pendings = job_listings.where(status: :pending).count
    total_rejections = job_listings.where(status: :rejected).count

    six_months_progress_data = job_listings.where("job_listings.created_at <= ?", 6.months.ago).group(:status).count.presence || 0

    { follow_up_list: follow_up_list, six_months_progress: six_months_progress, num_of_interviews_in_six_months: num_of_interviews_in_six_months, last_seven_days_progress: last_seven_days_progress, total_interviewings: total_interviewings, total_under_reviews: total_under_reviews, total_pendings: total_pendings, total_rejections: total_rejections, six_months_progress_data: six_months_progress_data }
  end
end

#
