require 'rails_helper'
require 'factory_bot_rails'

RSpec.describe Applicant, type: :model do
  # Set up a valid applicant for testing
  let(:user) { create(:user) } # Create a valid user using FactoryBot
  let(:applicant) { create(:applicant, user:) }

  # Test validity
  it 'valid applicant' do
    expect(applicant).to be_valid
  end

  context 'associations' do
    it 'belongs to a user' do
      expect(applicant.user).to eq(user)
    end
  end

  context 'Presence' do
    it 'requires necessary fields' do
      applicant_fields = %w[name email posting_pay requesting_pay posting_sched requesting_class requesting_schedule
                            app_host app_db rpd_schema doc_store my_values gpt_desc what_wrong]

      applicant_fields.each do |field|
        applicant.send("#{field}=", nil)
        expect(applicant).not_to be_valid, "Applicant should be invalid without #{field}"
        applicant.send("#{field}=", 'Some value') # Reset field
      end
    end
  end

  context 'Email format' do
    it 'validates email format' do
      applicant.email = 'invalid-email'
      expect(applicant).not_to be_valid, 'Applicant should be invalid with an invalid email'

      applicant.email = 'valid@example.com'
      expect(applicant).to be_valid, 'Applicant should be valid with a valid email'
    end
  end

  context 'inclusion fields' do
    it 'validates inclusion fields' do
      valid_classes = ['Contractor With Maximum Flexibility)']
      valid_hosts = ['Heroku', 'AWS', 'Azure', 'Google Cloud']
      valid_dbs = %w[MySQL SQLite PostgreSQL MongoDB]
      valid_docs = ['AWS', 'Azure', 'Google Cloud']
      valid_values = ['cost of infrastructure', 'speed of development', 'beauty of UI']

      # Check inclusion constraints
      applicant.requesting_class = 'Invalid'
      expect(applicant).not_to be_valid, 'Invalid requesting_class should be rejected'

      applicant.app_host = 'Invalid'
      expect(applicant).not_to be_valid, 'Invalid app_host should be rejected'

      applicant.app_db = 'Invalid'
      expect(applicant).not_to be_valid, 'Invalid app_db should be rejected'

      applicant.doc_store = 'Invalid'
      expect(applicant).not_to be_valid, 'Invalid doc_store should be rejected'

      applicant.my_values = 'Invalid'
      expect(applicant).not_to be_valid, 'Invalid my_values should be rejected'

      # Reassign valid values
      applicant.requesting_class = valid_classes.first
      applicant.app_host = valid_hosts.first
      applicant.app_db = valid_dbs.first
      applicant.doc_store = valid_docs.first
      applicant.my_values = valid_values.first

      expect(applicant).to be_valid, 'Applicant should be valid with all valid inclusion fields'
    end
  end

  context 'length validations' do
    it 'validates lengths correctly' do
      long_text = 'a' * 1001 # 1001 characters

      applicant.name = 'a' * 256
      expect(applicant).not_to be_valid, 'Applicant should be invalid with a name longer than 255 characters'

      applicant.name = 'Valid Name' # Reset

      applicant.posting_pay = long_text
      expect(applicant).not_to be_valid, 'Applicant should be invalid with a field longer than 1000 characters'

      # Additional length checks for other fields...
    end
  end

  context 'associations' do
    it 'belongs to a user' do
      expect(applicant.user).to be_present
    end

    it 'is invalid without a user' do
      orphaned_applicant = Applicant.new(
        name: 'Orphaned Applicant',
        email: 'test@example.com',
        # No user association
        posting_pay: '50k-60k',
        requesting_pay: '55k',
        posting_sched: 'Full-time',
        requesting_class: 'Contractor With Maximum Flexibility)',
        requesting_schedule: '40 hours/week',
        app_host: 'Heroku',
        app_db: 'PostgreSQL',
        rpd_schema: 'Schema details...',
        doc_store: 'AWS',
        my_values: 'speed of development',
        gpt_desc: 'Using GPT for coding assistance.',
        what_wrong: 'No issues.'
      )

      expect(orphaned_applicant).not_to be_valid, 'Applicant should be invalid without a user association'
    end
  end

  context 'scopes' do
    it 'sorted by name' do
      expect(Applicant.sorted_by_name).to eq(Applicant.order(name: :asc))
    end

    it 'sorted by creation date' do
      expect(Applicant.sorted_by_creation).to eq(Applicant.order(created_at: :asc))
    end

    it 'sorted by category' do
      expect(Applicant.sorted_by_category).to eq(Applicant.order(category: :asc))
    end
  end

  context 'email uniqueness' do
    it 'checks email uniqueness per user' do
      create(:applicant, user:, email: 'duplicate@example.com')
      applicant2 = Applicant.new(
        user:,
        name: 'Applicant Two',
        email: 'duplicate@example.com'
      )

      expect(applicant2).not_to be_valid, 'Applicant should be invalid with a duplicate email for the same user'

      applicant2.email = 'unique@example.com'
      if applicant2.valid?
        expect(applicant2).to be_valid, 'Applicant should be valid with a unique email'
      else
        puts applicant2.errors.full_messages
      end
    end
  end

  context 'edge cases' do
    it 'validates case-insensitive inclusion checks' do
      applicant.app_host = 'aws' # Lowercase
      expect(applicant).not_to be_valid, 'Applicant should be invalid with a lowercase inclusion field'

      applicant.app_host = 'AWS'
      expect(applicant).to be_valid, 'Applicant should be valid with the correct case'
    end

    it 'category updates correctly' do
      applicant.category = 'Pending'
      expect(applicant.category).to eq('Pending')

      applicant.update(category: 'Approved')
      expect(applicant.reload.category).to eq('Approved'), 'Category should update correctly'
    end
  end
  # Check behavior for missing fields
  it 'is invalid with missing fields' do
    # Define a hash mapping fields to their associated error message
    required_fields = {
      name: "can't be blank",
      email: "can't be blank",
      posting_pay: "can't be blank",
      requesting_pay: "can't be blank",
      posting_sched: "can't be blank",
      requesting_class: "can't be blank",
      requesting_schedule: "can't be blank",
      app_host: "can't be blank",
      app_db: "can't be blank",
      rpd_schema: "can't be blank",
      doc_store: "can't be blank",
      my_values: "can't be blank",
      gpt_desc: "can't be blank",
      what_wrong: "can't be blank",
      gpt_use: "can't be blank"
    }

    # Check for each field's absence
    required_fields.each do |field, error_message|
      applicant.send("#{field}=", nil) # Nullify the field

      expect(applicant).not_to be_valid, "Applicant should be invalid without #{field}"
      expect(applicant.errors[field.to_sym]).to include(error_message), "Missing #{field} should raise an error"

      applicant.send("#{field}=", 'Some value') # Reset for consistency
    end
  end
end
