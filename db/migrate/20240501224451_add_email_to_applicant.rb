class AddEmailToApplicant < ActiveRecord::Migration[7.0]
  def change
    add_column :applicants, :email, :string
  end
end
