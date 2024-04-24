class FollowUpPolicy < ApplicationPolicy
  def send_follow_up_email?
    user.present?
  end
end
