# frozen_string_literal: true

class AddScoreToApplicant < ActiveRecord::Migration[7.0]
  def change
    add_column :applicants, :score, :integer
  end
end
