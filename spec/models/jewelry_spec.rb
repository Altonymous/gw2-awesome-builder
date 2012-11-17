require 'spec_helper'

describe Jewelry do
  context 'associations' do
    it { should have_many :outfits }
    it { should have_and_belong_to_many :trinkets }
  end

  context 'mass assignment' do
    it { should_not allow_mass_assignment_of :outfits }
    it { should_not allow_mass_assignment_of :trinkets }
  end

  context 'validations' do
  end

  it 'has a valid factory' do
    create(:jewelry).should be_valid
  end
end
