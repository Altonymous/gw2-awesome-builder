# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :armor do
    name "MyString"
    kind 1
    slot 1
    defense "MyString"
    level 1
    armor_enhancements ""
    enhancements ""
  end
end
