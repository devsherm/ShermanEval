class ChangeApplicantDataTypeToS < ActiveRecord::Migration[7.0]
  def change
    change_column :applicants, :experience, :string
  end
end
