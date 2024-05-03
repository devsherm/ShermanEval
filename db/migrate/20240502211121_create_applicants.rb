class CreateApplicants < ActiveRecord::Migration[7.0]
  def change
    create_table :applicants do |t|
      t.string :email,        null: false, default: ""
      t.string :full_name,    null: false, default: ""
      t.string :how_find,     null: false, default: ""
      t.boolean :knows_ruby,  null: false, default: false
      t.boolean :knows_rails, null: false, default: false
      t.boolean :knows_mvc,   null: false, default: false
      t.string :status,       null: false, default: "Application Pending"
      t.timestamps
    end
  end
end
