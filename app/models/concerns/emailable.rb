module Emailable
  extend ActiveSupport::Concern

  # TODO: could this be in a mailer view?
  class_methods do
      def follow_up_email_template
      "Hello,<br><br>
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
  end
end
