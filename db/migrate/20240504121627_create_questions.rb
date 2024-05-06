class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.string :key
      t.string :answer_type
      t.text :text
      t.text :options

      t.timestamps
    end
  end
end
