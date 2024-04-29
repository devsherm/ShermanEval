# frozen_string_literal: true

class CreateApplicants < ActiveRecord::Migration[7.0]
  def change
    create_table :applicants do |t|
      t.references :user, null: false, foreign_key: true

      t.string :first_name
      t.string :last_name
      t.string :email
      t.integer :age
      t.string :gender
      t.string :skills

      t.timestamps
    end
  end
end
