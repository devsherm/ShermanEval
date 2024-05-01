class AddJobSubmissions < ActiveRecord::Migration[7.0]
  def change
    create_table :job_submissions do |t|
      t.integer :job_application_id, null:false
      t.jsonb :job_submission_data, null:false
      
      t.integer :status, null:false, default: 0

      t.integer :created_by_id, null:false
      t.integer :updated_by_id, null: false

      t.timestamps
    end
  end
end

#What was the Pay Range in the Posting for this Job?
#What employment class would you prefer?
#What service is Hosting this App?
#Which Database does this App use?