class AddSubmissionsCountToJobApplications < ActiveRecord::Migration[7.0]
  def change
    add_column :job_applications, :job_submissions_count, :integer, default: 0

    JobApplication.find_each do |job_application|
      JobApplication.reset_counters(job_application.id, :job_submissions)
    end
  end
end
