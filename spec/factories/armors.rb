    # Read about factories at https://github.com/thoughtbot/factory_girl

    FactoryGirl.define do
      factory :armor do
        sequence(:name) { |n| "Armor ##{n}" }
        defense 1
        level 1

        weight
        slot
      end
    end
