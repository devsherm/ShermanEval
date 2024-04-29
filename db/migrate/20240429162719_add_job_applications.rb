class AddJobApplications < ActiveRecord::Migration[7.0]
  def change
    create_table :job_applications do |t|
      t.string :job_title
      t.text :job_description
      t.integer :job_department
      t.integer :job_position
      
      t.integer :status

      t.integer :created_by_id, null:false
      t.integer :updated_by_id, null: false

      t.timestamps
    end
    
  end
end
