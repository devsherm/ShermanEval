class UserApplicationPolicy < ApplicationPolicy
  def index? = true
  def create? = owner?
  def new? = true
  def update? = owner_or_admin?
  def edit? = owner_or_admin?
  def destroy? = owner_or_admin?

  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.admin?
        scope.where(employer: user)
      else
        scope.where(user:)
      end
    end
  end

  def owner_or_admin?
    owner? || user.admin?
  end

  def owner?
    record.user == user
  end
end
