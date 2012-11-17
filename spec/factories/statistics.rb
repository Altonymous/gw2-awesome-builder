# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :statistic do
    sequence(:name) { |n| "Statistic ##{n}" }
  end
end
