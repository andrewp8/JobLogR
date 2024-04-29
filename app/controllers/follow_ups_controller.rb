class FollowUpsController < ApplicationController
  def send_follow_up_email
    # :follow_up serves as a symbolic representation of the FollowUp model class and helps Pundit locate the appropriate policy class and apply the authorization logic for the send_follow_up_email action.
    authorize :follow_up, :send_follow_up_email?
    recipient_email = params[:recipient_email]
    email_body = params[:email_body]
    subject = params[:subject]
    job_listing = JobListing.find(params[:job_listing_id])
    user = User.find(params[:user_id])
    full_name = "#{user.first_name.capitalize} #{user.last_name.capitalize}"
    begin
      FollowUpMailer.follow_up_email(recipient_email, email_body, subject, full_name).deliver_now
      redirect_to job_listing_url(job_listing), notice: "Follow-up email sent successfully!"
    rescue Postmark::ApiInputError => e
      flash[:alert] = "Currently, we can only send emails to addresses within our domain. Please use an email address that ends with '@joblogr.org'."
      redirect_to job_listing_url(job_listing)
    rescue StandardError => e
      flash[:alert] = "An unexpected error occurred: #{e.message}"
      redirect_to job_listing_url(job_listing)
    end
  end
end
