class CreateApplicants < ActiveRecord::Migration[7.0]
  def change
    create_table :applicants do |t|
      t.string :full_name, null: false
      t.string :email, null: false
      t.text :experience_summary, null: false
      t.string :primary_backend_language, null: false
      t.string :tech_stack, array: true, default: [], null: false
      t.integer :status, default: 0
      t.belongs_to :user, foreign_key: true, optional: true
      t.timestamps
    end
  end
end
