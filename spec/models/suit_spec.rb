require 'spec_helper'

describe Suit do
  context 'associations' do
    it { should have_many :outfits }
    it { should have_and_belong_to_many :armors }
  end

  context 'mass assignment' do
    it { should_not allow_mass_assignment_of :outfits }
    it { should_not allow_mass_assignment_of :armors }
  end

  context 'validations' do
    it { should validate_presence_of(:armors) }
  end

  it 'has a valid factory' do
    create(:suit).should be_valid
  end
end
