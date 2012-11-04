# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :gear_enhancement do
    enhancement
    rating 1

    factory :armor_enhancement do
      association :gear, factory: :armor
    end
  end
end
