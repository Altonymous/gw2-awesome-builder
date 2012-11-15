# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :armor do
    sequence(:name) { |n| "Armor ##{n}" }
    level 1

    weight { Weight.first }
    slot { Slot.find_by_name('Helm') }

    ignore do
      rating 1
      enhancement { Enhancement.find_by_name('Toughness') }
      outfit { create(:outfit) }
    end

    trait :with_enhancement do
      after(:build) do |armor, evaluator|
        armor.gear_enhancements.build({rating: evaluator.rating}).enhancement = evaluator.enhancement
      end
    end

    trait :with_all_enhancements do
      after(:build) do |armor, evaluator|
        Enhancement.all.each do |enhancement|
          armor.gear_enhancements.build({rating: evaluator.rating}).enhancement = enhancement
        end
      end
    end

    trait :with_outfit do
      after(:build) do |armor, evaluator|
        armor.outfits << evaluator.outfit
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
