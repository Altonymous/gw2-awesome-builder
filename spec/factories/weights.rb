# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :weight do
    sequence(:name) { |n| "Weight ##{n}" }

    factory :weight_with_armors do
      ignore do
        armors_count 5
      end

      after(:create) do |weight, evaluator|
        create_list(:armor, evaluator.armors_count, weight: weight)
      end
    end
  end
end
