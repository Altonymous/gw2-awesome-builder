# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :trinket do
    sequence(:name) { |n| "Trinket ##{n}" }
    level 1

    slot { Slot.find_by_name('Amulet') }

    trait :with_enhancement do
      after(:build) do |trinket|
        trinket.gear_enhancements.build({rating: 1}).enhancement = Enhancement.first
      end
    end

    trait :ring_1 do
      slot { Slot.find_by_name("Ring 1") }
    end

    trait :ring_2 do
      slot { Slot.find_by_name("Ring 2") }
    end

    trait :accessory_1 do
      slot { Slot.find_by_name("Accessory 1") }
    end

    trait :accessory_2 do
      slot { Slot.find_by_name("Accessory 2") }
    end

    trait :amulet do
      slot { Slot.find_by_name("Amulet") }
    end
  end
end
