# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :weapon do
    name "MyString"
    level 1
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
    slot nil
    gw2db_url "MyString"
    icon_url "MyString"
  end
end
