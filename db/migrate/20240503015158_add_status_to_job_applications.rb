class AddStatusToJobApplications < ActiveRecord::Migration[6.0]
  def change
    add_column :job_applications, :status, :integer, default: 0
  end
end