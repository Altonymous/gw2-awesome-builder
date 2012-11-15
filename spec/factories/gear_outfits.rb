# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :gear_outfit do
    outfit_id { create(:outfit) }

    trait :helm do
      gear_id { create(:armor, :helm, :with_enhancement) }
      gear_type 'Armor'
    end
  end
end
