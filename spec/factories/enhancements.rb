# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :enhancement do
    sequence(:name) { |n| "Enhancement ##{n}" }
    multiplier 1

    statistic
  end
end
