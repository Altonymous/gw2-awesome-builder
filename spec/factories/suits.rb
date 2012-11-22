# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :suit do
    weight_id 1

    ignore do
      gear { create(:armor) }
    end

    after(:build) do |suit, evaluator|
      suit.armors << evaluator.gear
    end

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
  end
end
