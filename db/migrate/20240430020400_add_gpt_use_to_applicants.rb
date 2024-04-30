class AddGptUseToApplicants < ActiveRecord::Migration[7.0]
  def change
    add_column :applicants, :gpt_use, :boolean, default: false
  end
end
