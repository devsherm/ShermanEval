class CreateSurveys < ActiveRecord::Migration[7.0]
  def change
    create_table :surveys do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :last_project
      t.string :favorite_cube
      t.boolean :like_ruby
      t.string :evaluation

      t.timestamps
    end
  end
end
