class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :landing_page?

  def time_ago_in_words(timestamp)
    now = Time.zone.now
    diff_in_days = (now - timestamp).to_i / 1.day

    if timestamp.to_date == now.to_date
      "Created today"
    else
      months = diff_in_days / 30
      weeks = (diff_in_days % 30) / 7
      days = diff_in_days % 7

      time_ago = []
      time_ago << "#{months} months" if months > 0
      time_ago << "#{weeks} weeks" if weeks > 0
      time_ago << "#{days} days" if days > 0

      ago_string = "Created #{time_ago.join(', ')} ago"
      date_string = timestamp.strftime('%m/%d/%Y')

      "#{ago_string}, #{date_string}"
    end
  end

  private

  def landing_page?
    request.path == root_path
  end

  def after_sign_in_path_for(resource)
    boards_path
  end
  # skip_forgery_protection
end
