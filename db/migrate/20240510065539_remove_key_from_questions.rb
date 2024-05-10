class RemoveKeyFromQuestions < ActiveRecord::Migration[7.0]
  def change
    remove_column :questions, :key, :string
  end
end
