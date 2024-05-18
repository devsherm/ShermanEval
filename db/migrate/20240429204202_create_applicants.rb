class CreateApplicants < ActiveRecord::Migration[7.0]
  def change
    create_table :applicants do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.integer :job_type, null: false
      t.date :start_date, null: false
      t.boolean :agree_tc, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
