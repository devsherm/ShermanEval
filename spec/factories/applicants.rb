FactoryBot.define do
  factory :applicant do
    user { nil }
    name { 'MyString' }
    email { 'MyString' }
    posting_pay { 'MyString' }
    requesting_pay { 'MyString' }
    posting_sched { 'MyString' }
    requesting_class { 'MyString' }
    requesting_schedule { 'MyText' }
    app_host { 'MyString' }
    app_db { 'MyString' }
    rpd_schema { 'MyText' }
    doc_store { 'MyString' }
    my_values { 'MyString' }
    gpt_desc { 'MyText' }
    what_wrong { 'MyText' }
  end
end
