# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :slot do
    sequence(:name) { |n| "Slot ##{n}" }
    slot_type "Armor"
  end
end
