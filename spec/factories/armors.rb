# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :armor do
    sequence(:name) { |n| "Armor ##{n}" }
    level 1

    weight { Weight.first }
    slot { Slot.find_by_name('Head') }

    ignore do
      rating 1
    end

    trait :with_enhancement do
      after(:build) do |armor, evaluator|
        armor.gear_enhancements.build({rating: evaluator.rating}).enhancement = Enhancement.first
      end
    end

    trait :with_all_enhancements do
      after(:build) do |armor, evaluator|
        Enhancement.all.each do |enhancement|
          armor.gear_enhancements.build({rating: evaluator.rating}).enhancement = enhancement
        end
      end
    end

    trait :head do
      slot { Slot.find_by_name("Head") }
    end

    trait :shoulders do
      slot { Slot.find_by_name("Shoulders") }
    end

    trait :chest do
      slot { Slot.find_by_name("Chest") }
    end

    trait :arms do
      slot { Slot.find_by_name("Arms") }
    end

    trait :legs do
      slot { Slot.find_by_name("Legs") }
    end

    trait :feet do
      slot { Slot.find_by_name("Feet") }
    end
  end
end
