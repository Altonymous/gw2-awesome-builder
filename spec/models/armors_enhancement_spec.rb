require 'spec_helper'

describe ArmorsEnhancement do
  context 'associations' do
    it { should belong_to :armor }
    it { should belong_to :enhancement }
  end

  context 'mass assignment' do
    it { should allow_mass_assignment_of :rating }
  end

  it 'has a valid factory' do
    create(:armors_enhancement).should be_valid
  end

  context 'is invalid without' do
    it 'a rating' do
      build(:armors_enhancement, rating: nil).should_not be_valid
    end

    it 'a armor' do
      build(:armors_enhancement, armor: nil).should_not be_valid
    end

    it 'an enhancement' do
      build(:armors_enhancement, enhancement: nil).should_not be_valid
    end
  end

  context 'is invalid if' do
    it 'rating is not a number' do
      build(:armors_enhancement, rating: "Test").should_not be_valid
    end

    it 'rating is not greater than zero' do
      build(:armors_enhancement, rating: 0).should_not be_valid
    end

    it 'rating is not an integer' do
      build(:armors_enhancement, rating: 1.1).should_not be_valid
    end
  end
end
