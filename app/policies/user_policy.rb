class UserPolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def update?
    show?
  end

  def show?
    @user.id == record.id || user.admin?
  end

  def new?
    true
  end

  def create?
    true 
  end 

  def edit?
    show?
  end 

  def destroy?
    update?
  end
end