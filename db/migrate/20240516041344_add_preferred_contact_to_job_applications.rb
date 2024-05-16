class AddPreferredContactToJobApplications < ActiveRecord::Migration[7.0]
  def change
    add_column :job_applications, :preferred_contact, :string, null: false, default: "No Preference"
  end
end
