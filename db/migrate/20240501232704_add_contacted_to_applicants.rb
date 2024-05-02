class AddContactedToApplicants < ActiveRecord::Migration[7.0]
  def change
    add_column :applicants, :contacted, :boolean, default: false
  end
end
