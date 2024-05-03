class CreateJobApplications < ActiveRecord::Migration[7.0]
  def change
    create_table :job_applications do |t|
      t.string :name
      t.string :experience_level
      t.boolean :remote_ok

      t.timestamps
    end
  end
end
