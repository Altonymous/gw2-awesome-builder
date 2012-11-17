require 'spec_helper'

describe Weight do
  context 'associations' do
    it { should have_many :armors }
  end

  context 'mass assignment' do
    it { should allow_mass_assignment_of :name }
    it { should_not allow_mass_assignment_of :armors }
  end

  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should ensure_length_of(:name).is_at_most(16) }
  end

  it 'has a valid factory' do
    create(:weight).should be_valid
  end
end
