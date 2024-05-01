class ChangeApplicantDataType < ActiveRecord::Migration[7.0]
  def change
    change_column :applicants, :experience, :boolean, using: 'experience::boolean'
  end
end
