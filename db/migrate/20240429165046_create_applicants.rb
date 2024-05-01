class CreateApplicants < ActiveRecord::Migration[7.0]
  def change
    create_table :applicants do |t|
      t.string :name
      t.string :experience
      t.string :availability

      t.timestamps
    end
  end
end
