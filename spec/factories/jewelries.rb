# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :jewelry do
    ignore do
      gear { create(:trinket) }
    end

    after(:build) do |jewelry, evaluator|
      jewelry.trinkets << evaluator.gear
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
