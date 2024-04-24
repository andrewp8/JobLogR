class JobListingPolicy < ApplicationPolicy
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      user.admin? ? scope.all : scope.where(user: user)
    end
  end

  # Policy methods
  def index?
    true  # Anyone logged in can access the index page because records are explicitly fetched from the current_user
  end

  def show?
    user_has_access?
  end

  def new?
    user.admin?
  end
  def create?
    user.present?  # Any logged-in user can create a board
  end

  def edit?
    user.admin?
  end

  def update?
    user_has_access?
  end

  def destroy?
    user_has_access? && user.admin?  # Only admin can delete, and must also be the owner
  end

  private

  # Centralized access check
  def user_has_access?
    return false if record.nil?
    user.admin? || record.user == user
  end
end
