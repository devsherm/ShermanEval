class UserApplicationPolicy < ApplicationPolicy
  def index?
    true
  end

  def update?
    user.admin?
  end

  def show?
    @user.id == record.user_id
  end
end