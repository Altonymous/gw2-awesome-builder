# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :gear_enhancement do
    enhancement_id { Enhancement.first.id }
    rating 1

    factory :armor_enhancement do
      gear { build(:armor, :head, :with_enhancement) }
    end
  end
end
