# frozen_string_literal: true

class ApplicantPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    true
  end

  def new?
    true
  end

  def update?
    admin?
  end

  def destroy?
    admin?
  end

  def mail?
    admin?
  end

  private

  def admin?
    user.admin?
  end
end
