class AddJobApplications < ActiveRecord::Migration[7.0]
  def change
    create_table :job_applications do |t|
      t.string :job_title
      t.integer :job_department
      t.integer :job_position

      t.references :user, null: false, foreign_key: true
      
      t.integer :status

      t.integer :created_by_id, null:false
      t.integer :updated_by_id, null: false

      t.timestamps
    end
    
  end
end
