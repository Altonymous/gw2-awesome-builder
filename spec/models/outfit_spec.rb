require 'spec_helper'

describe Outfit do
  context 'associations' do
    it { should belong_to :suit }
    it { should belong_to :jewelry }
  end

  context 'mass assignment' do
    it { should allow_mass_assignment_of :suit_id }
    it { should allow_mass_assignment_of :jewelry_id }
    it { should_not allow_mass_assignment_of :suit }
    it { should_not allow_mass_assignment_of :jewelry }
  end

  context 'validations' do
    it { should validate_presence_of(:suit_id) }

    it { should validate_presence_of(:jewelry_id) }
  end

  it 'has a valid factory' do
    create(:outfit).should be_valid
  end
end
