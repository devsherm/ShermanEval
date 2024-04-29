# app/models/ability.rb

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?
      # Admin permissions
      can :manage, Applicant
      can :manage, User
    else
      # User permissions
      can :create, Applicant
      # Only the user can read, edit, and update their own  applications
      can :read, Applicant, user_id: user.id
      can :edit, Applicant, user_id: user.id
      can :update, Applicant, user_id: user.id

      # Only the user can read, edit, update, and destroy their own profile
      can :read, User, id: user.id
      can :update, User, id: user.id
      can :destroy, User, id: user.id
    end
  end
end
