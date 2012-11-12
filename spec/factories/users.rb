# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name 'Test User'
    email 'user@example.com'
    password 'please'
    password_confirmation 'please'
    # required if the Devise Confirmable module is used
    confirmed_at Time.now

    trait :administrator do
      name 'Test Administrator'
      email 'administrator@example.com'

      after(:build) do |administrator|
        administrator.add_role(:administrator)
      end
    end
  end
end