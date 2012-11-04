# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :slot do
    sequence(:name) { |n| "Slot ##{n}" }

    factory :slot_with_armors do
      ignore do
        armors_count 5
      end

      after(:create) do |slot, evaluator|
        create_list(:armor, evaluator.armors_count, slot: slot)
      end
    end
  end
end
