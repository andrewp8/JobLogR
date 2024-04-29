class FollowUpMailer < ApplicationMailer
  def follow_up_email(recipient_email, email_body, subject, full_name)
    mail(from: "#{full_name} <service@joblogr.org>", to: recipient_email, subject: subject) do |format|
      format.html { render html: email_body.html_safe }
    end
  end
end
