# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :slot do
    sequence(:name) { |n| "Slot ##{n}" }

    factory :head_slot do
      name "Head"
    end

    factory :shoulders_slot do
      name "Shoulders"
    end

    factory :chest_slot do
      name "Chest"
    end

    factory :arms_slot do
      name "Arms"
    end

    factory :legs_slot do
      name "Legs"
    end

    factory :feet_slot do
      name "Feet"
    end
  end
end
