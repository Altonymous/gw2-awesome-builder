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

    factory :head do
      association :slot, factory: :head_slot
    end

    factory :shoulders do
      association :slot, factory: :shoulders_slot
    end

    factory :chest do
      association :slot, factory: :chest_slot
    end

    factory :arms do
      association :slot, factory: :arms_slot
    end

    factory :legs do
      association :slot, factory: :legs_slot
    end

    factory :feet do
      association :slot, factory: :feet_slot
    end
  end
end
