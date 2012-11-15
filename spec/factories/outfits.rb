# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :outfit do
    armor 0
    attack_power 0
    hit_points 0
    critical_chance 0
    critical_damage 0
    condition_damage 0
    condition_duration 0
    healing_power 0
    boon_duration 0

    ignore do
      helm { create(:armor, :helm, :with_enhancement) }
    end

    trait :helm do
      after(:build) do |outfit, evaluator|
        outfit.gears << evaluator.helm
      end
    end
  end
end
