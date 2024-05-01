class AddNoteToJobSubmissions < ActiveRecord::Migration[7.0]
  def change
    add_column :job_submissions, :note_to_applicant, :text
  end
end
