class CreateJobApplications < ActiveRecord::Migration[7.0]
  def change
    create_table :job_applications do |t|
      t.text :summary, null: false
      t.string :experience, null: false
      t.string :git_competence, null: false
      t.string :rails_competence, null: false
      t.boolean :terms, null: false, default: false
      t.string :status, default: "Pending"
      t.string :email, null: false
      t.string :name, null: false
      t.references :user, null: false, foreign_key: true, index: { unique: true }

      t.timestamps
    end
  end
end
