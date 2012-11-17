# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :armor do
    sequence(:name) { |n| "Armor ##{n}" }
    level 80

    weight { Weight.first }
    slot { Slot.find_by_name('Helm') }

    armor 1
    hit_points 1
    attack_power 1
    critical_damage 1
    critical_chance 1
    condition_damage 1
    condition_duration 1
    healing_power 1
    boon_duration 1
    magic_find 1

    ignore do
      rating 1
      enhancement { Enhancement.find_by_name('Toughness') }
      suit { create(:suit) }
    end

    after(:build) do |armor, evaluator|
      armor.gear_enhancements.build({rating: evaluator.rating}).enhancement = evaluator.enhancement
    end

    trait :with_all_enhancements do
      after(:build) do |armor, evaluator|
        Enhancement.all.each do |enhancement|
          armor.gear_enhancements.build({rating: evaluator.rating}).enhancement = enhancement
        end
      end
    end

    trait :with_suit do
      after(:build) do |armor, evaluator|
        armor.suit = evaluator.suit
      end
    end

    trait :helm do
      slot { Slot.find_by_name("Helm") }
    end

    trait :shoulders do
      slot { Slot.find_by_name("Shoulders") }
    end

    trait :coat do
      slot { Slot.find_by_name("Coat") }
    end

    trait :gloves do
      slot { Slot.find_by_name("Gloves") }
    end

    trait :legs do
      slot { Slot.find_by_name("Legs") }
    end

    trait :boots do
      slot { Slot.find_by_name("Boots") }
    end
  end
end
