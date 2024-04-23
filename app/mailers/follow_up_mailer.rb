class FollowUpMailer < ApplicationMailer
  def follow_up_email(recipient_email, email_body, subject)

    # TODO: this from will not work as intended
    # Andrew Pham <notifications@joblogr.com>
    mail(from: ENV["GMAIL_ADDRESS"], to: recipient_email, subject:  subject) do |format|
      format.html { render html: email_body.html_safe }
    end
  end
end
