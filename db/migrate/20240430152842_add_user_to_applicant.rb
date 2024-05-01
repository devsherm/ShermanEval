class AddUserToApplicant < ActiveRecord::Migration[7.0]
  def change
    add_reference :applicants, :user, null: false, foreign_key: true
  end
end
