# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :outfit do
    helm { create(:armor, :helm, :with_enhancement) }
    shoulders { create(:armor, :shoulders, :with_enhancement) }
    coat { create(:armor, :coat, :with_enhancement) }
    gloves { create(:armor, :gloves, :with_enhancement) }
    legs { create(:armor, :legs, :with_enhancement) }
    boots { create(:armor, :boots, :with_enhancement) }

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
