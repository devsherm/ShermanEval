class CreateUserApplications < ActiveRecord::Migration[7.0]
  def change
    create_table :user_applications do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.references :user, null: false, foreign_key: true
      t.jsonb :skills, null: false
      t.text :about_me
      t.integer :gender
      t.integer :score

      t.timestamps
    end
  end
end
