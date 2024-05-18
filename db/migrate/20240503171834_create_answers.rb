class CreateAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :answers do |t|
      t.string :key
      t.text :value
      t.belongs_to :applicant, null: false, foreign_key: true
      t.string :applicant

      t.timestamps
    end
  end
end
