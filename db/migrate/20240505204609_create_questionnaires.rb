class CreateQuestionnaires < ActiveRecord::Migration[7.0]
  def change
    create_table :questionnaires do |t|
      t.text :long_text
      t.string :short_text
      t.string :radio_choice
      t.boolean :checkbox
      t.string :category
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
