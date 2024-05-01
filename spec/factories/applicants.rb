FactoryBot.define do
  factory :applicant do
    association :user # Automatically associates with a valid user

    # Fields with reasonable default values
    name { 'John Doe' }
    email { 'john.doe@example.com' }
    posting_pay { '50k-60k' }
    requesting_pay { '55k' }
    posting_sched { 'Full-time' }
    requesting_class { 'Contractor With Maximum Flexibility)' }
    requesting_schedule { '40 hours/week' }
    app_host { 'Heroku' }
    app_db { 'PostgreSQL' }
    rpd_schema { 'Schema details...' }
    doc_store { 'AWS' }
    my_values { 'speed of development' }
    gpt_desc { 'Using GPT for coding assistance.' }
    what_wrong { 'No issues at the moment.' }

    gpt_use { true } # Boolean field

    category { 'Pending' } # Optional but valid field

    # Additional nested factory for creating a categorized applicant
    factory :categorized_applicant do
      category { 'Approved' }
    end

    # Additional factory traits can be added here...
  end
end
