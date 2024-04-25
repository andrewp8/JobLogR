class PagePolicy < ApplicationPolicy
  def feedback
    user.present?
  end
end
