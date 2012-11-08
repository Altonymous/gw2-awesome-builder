# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :armor do
    sequence(:name) { |n| "Armor ##{n}" }
    level 1

    weight
    slot

    before(:create) do |armor|
      armor.gear_enhancements.build({rating: 1}).enhancement = create(:enhancement)
    end
  end
end
