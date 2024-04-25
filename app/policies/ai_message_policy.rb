class AiMessagePolicy < ApplicationPolicy
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
        joins(job_listing: { board: :user })
        .where(users: { id: user.id })
      end
    end
  end

  # Policy methods
  def index?
    user.admin?
  end

  def show?
    user.admin?
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

  private

  # Centralized access check
  def user_has_access?
    return false if record.nil?
    # user.admin? || scope.where(id: record.id).exists?
    user.admin? || record.job_listing.board.user == user
  end
end
