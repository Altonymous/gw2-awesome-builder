# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :outfit do
    association :head, factory: :head
    association :shoulders, factory: :shoulders
    association :chest, factory: :chest
    association :arms, factory: :arms
    association :legs, factory: :legs
    association :feet, factory: :feet
  end
end
