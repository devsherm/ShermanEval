class AddEvalToApplicant < ActiveRecord::Migration[7.0]
  def change
    add_column :applicants, :eval, :integer
  end
end
