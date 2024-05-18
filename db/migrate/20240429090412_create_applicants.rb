class CreateApplicants < ActiveRecord::Migration[7.0]
  def change
    create_table :applicants do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :salary, null: false, default: 0
      t.boolean :hybrid_option, null: false, default: false
      t.string :rails_level, null: false, default: 'newbie'
      t.string :perks, array: true, default: []
      t.integer :test_score

      t.timestamps
    end
  end
end
