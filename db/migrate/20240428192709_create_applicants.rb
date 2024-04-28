class CreateApplicants < ActiveRecord::Migration[7.0]
  def change
    create_table :applicants do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :my_level
      t.boolean :scratch_before
      t.string :fav_hobby

      t.timestamps
    end
  end
end
