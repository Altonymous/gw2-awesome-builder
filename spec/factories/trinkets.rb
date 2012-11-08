# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :trinket do
    sequence(:name) { |n| "Trinket ##{n}" }
    level 1

    slot

    before(:create) do |trinket|
      trinket.gear_enhancements.build({rating: 1}).enhancement = create(:enhancement)
    end
  end
end
