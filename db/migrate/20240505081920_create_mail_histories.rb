class CreateMailHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :mail_histories do |t|
      t.string :subject
      t.string :status
      t.string :sender_email
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
