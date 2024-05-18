class CreateUserApplications < ActiveRecord::Migration[7.0]
  def change
    create_table :user_applications do |t|
      t.references :user, foreign_key: true
      t.references :employer, foreign_key: { to_table: :users }
      t.integer :my_level
      t.boolean :scratch_before
      t.string :fav_hobby
      t.integer :eval

      t.timestamps
    end
  end
end
