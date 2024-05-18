class CreateApplicantCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :applicant_categories do |t|
      t.references :category, null: false, foreign_key: true
      t.references :applicant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
