# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :statistic do
    name "MyString"
    kind "numeric"
    minimum 1
    maximum 3000
    interval 10
  end
end
