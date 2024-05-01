class CreateApplicants < ActiveRecord::Migration[7.0]
  def change
    create_table :applicants do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :email
      t.string :posting_pay
      t.string :requesting_pay
      t.string :posting_sched
      t.string :requesting_class
      t.text :requesting_schedule
      t.string :app_host
      t.string :app_db
      t.text :rpd_schema
      t.string :doc_store
      t.string :my_values
      t.text :gpt_desc
      t.text :what_wrong

      t.timestamps
    end
  end
end
