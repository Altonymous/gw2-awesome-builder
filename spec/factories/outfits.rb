# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :outfit do
    suit { create(:suit) }
    jewelry { create(:jewelry) }

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
  end
end
