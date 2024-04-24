class JobListingPolicy < ApplicationPolicy
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.admin?
        scope.all
      else
        scope.joins(board: :user).where(users: { id: user.id })
      end
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
    user_has_access?
  end

  def application_insights?
    true
  end

  def update_status?
    user_has_access?
  end
  private

  # Centralized access check
  def user_has_access?
    return false if record.nil?
    # user.admin? || scope.where(id: record.id).exists?
    user.admin? || record.board.user == user
  end
end
