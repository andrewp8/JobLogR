class ApplicationMailer < ActionMailer::Base
  default from: ENV["POSTMARK_SERVER_EMAIL_ADDRESS"]
  layout "mailer"
end
