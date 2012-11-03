# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence(:enhancement_name) { |n| "Enhancement ##{n}" }

  factory :enhancement do
    name "MyString"
    statistic nil
    multiplier 1
  end
end
