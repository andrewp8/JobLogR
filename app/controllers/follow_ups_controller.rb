class FollowUpsController < ApplicationController
  def send_follow_up_email
    recipient_email = params[:recipient_email]
    email_body = params[:email_body]
    current_user = User.find(params[:user_id])
    puts "-ABC #{current_user.first_name}"
    job_listing = JobListing.find(params[:job_listing_id])
    FollowUpMailer.follow_up_email(recipient_email, email_body, current_user, job_listing).deliver_now

    redirect_to job_listing_url(job_listing), notice: "Follow-up email sent successfully!"
  end
end
