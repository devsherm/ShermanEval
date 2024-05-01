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

  def new?
    true
  end

  def create?
    show? 
  end 

  def edit?
    update?
  end 

  def destroy?
    update?
  end

  def email_applicant?
    user.admin?
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(user: user)
      end
    end
  end
end