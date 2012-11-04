require 'spec_helper'

describe GearEnhancement do
  context 'associations' do
    it { should belong_to :gear }
    it { should belong_to :enhancement }
  end

  context 'mass assignment' do
    it { should allow_mass_assignment_of :rating }
  end

  context 'as an armor enhancement' do
    it 'has a valid factory' do
      create(:armor_enhancement).should be_valid
    end

    context 'is invalid without' do
      it 'a rating' do
        build(:armor_enhancement, rating: nil).should_not be_valid
      end

      it 'an armor' do
        build(:armor_enhancement, gear: nil).should_not be_valid
      end

      it 'an enhancement' do
        build(:armor_enhancement, enhancement: nil).should_not be_valid
      end
    end

    context 'is invalid if' do
      it 'rating is not a number' do
        build(:armor_enhancement, rating: "Test").should_not be_valid
      end

      it 'rating is not greater than zero' do
        build(:armor_enhancement, rating: 0).should_not be_valid
      end

      it 'rating is not an integer' do
        build(:armor_enhancement, rating: 1.1).should_not be_valid
      end
    end
  end
end
