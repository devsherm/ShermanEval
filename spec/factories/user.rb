FactoryBot.define do
  factory :user do
    # Default user details
    email { Faker::Internet.email }
    password { 'password123' } # Default password for testing convenience
    password_confirmation { 'password123' }

    name { Faker::Name.name }

    # Additional traits for different types of users
    trait :admin do
      admin { true }
    end

    trait :standard_user do
      admin { false }
    end

    # Nested factory for directly creating an admin user
    factory :admin_user, traits: [:admin]
  end
end
