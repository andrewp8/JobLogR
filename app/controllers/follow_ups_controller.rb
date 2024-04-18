class FollowUpsController < ApplicationController
  def send_follow_up_email
    recipient_email = params[:recipient_email]
    email_body = params[:email_body]
    subject = params[:subject]
    job_listing = JobListing.find(params[:job_listing_id])
    FollowUpMailer.follow_up_email(recipient_email, email_body, subject).deliver_now

    redirect_to job_listing_url(job_listing), notice: "Follow-up email sent successfully!"
  end
end
