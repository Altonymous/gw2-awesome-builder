# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :outfit do
    head { create(:armor, :head, :with_enhancement) }
    shoulders { create(:armor, :shoulders, :with_enhancement) }
    chest { create(:armor, :chest, :with_enhancement) }
    arms { create(:armor, :arms, :with_enhancement) }
    legs { create(:armor, :legs, :with_enhancement) }
    feet { create(:armor, :feet, :with_enhancement) }

    armor 0
    attack_power 0
    hit_points 0
    critical_chance 0
    critical_damage 0
    condition_damage 0
    condition_duration 0
    healing_power 0
    boon_duration 0
  end
end
