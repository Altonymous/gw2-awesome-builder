# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :trinket do
    sequence(:name) { |n| "Trinket ##{n}" }
    level 80

    slot { Slot.find_by_name('Amulet') }

    armor 0
    attack_power 0
    hit_points 0
    critical_chance 0
    critical_damage 0
    condition_damage 0
    condition_duration 0
    healing_power 0
    boon_duration 0
    magic_find 0

    ignore do
      rating 1
      enhancement { Enhancement.find_by_name('Toughness') }
      jewelry { create(:jewelry) }
    end

    trait :with_enhancement do
      after(:build) do |trinket, evaluator|
        trinket.gear_enhancements.build({rating: evaluator.rating}).enhancement = evaluator.enhancement
      end
    end

    trait :with_all_enhancements do
      after(:build) do |trinket, evaluator|
        Enhancement.all.each do |enhancement|
          trinket.gear_enhancements.build({rating: evaluator.rating}).enhancement = enhancement
        end
      end
    end

    trait :with_jewelry do
      after(:build) do |trinket, evaluator|
        trinket.jewelry = evaluator.jewelry
      end
    end

    trait :ring do
      slot { Slot.find_by_name("Ring") }
    end

    trait :accessory do
      slot { Slot.find_by_name("Accessory") }
    end

    trait :amulet do
      slot { Slot.find_by_name("Amulet") }
    end
  end
end
