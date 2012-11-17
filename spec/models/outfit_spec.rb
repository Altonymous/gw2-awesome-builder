require 'spec_helper'

describe Outfit do
  context 'associations' do
    it { should belong_to :suit }
    it { should belong_to :jewelry }
  end

  context 'mass assignment' do
    it { should allow_mass_assignment_of :suit_id }
    it { should allow_mass_assignment_of :jewelry_id }
  end

  it 'has a valid factory' do
    create(:outfit).should be_valid
  end

  context 'is invalid without' do
    it 'suit' do
      build(:outfit, suit_id: nil).should_not be_valid
      build(:outfit, suit: nil).should_not be_valid
    end

    it 'jewelry' do
      build(:outfit, jewelry_id: nil).should_not be_valid
      build(:outfit, jewelry: nil).should_not be_valid
    end
  end

  context 'is invalid if' do
  end
end
