class BoardPolicy < ApplicationPolicy
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
    true  # Assume anyone logged in can access the index page
  end

  def show?
    user_has_access?
  end

  def new?
    user.admin?
  end
  def create?
    user.present?  # Assumes that any logged-in user can create a board
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
