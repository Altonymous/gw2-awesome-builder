require 'spec_helper'

describe Enhancement do
  context 'associations' do
    it { should belong_to :statistic }
    it { should have_many :gear_enhancements }

    # Polymorphic Associations
    it { should have_many :armors }
    it { should have_many :trinkets }
  end

  context 'mass assignment' do
    it { should allow_mass_assignment_of :name }
    it { should allow_mass_assignment_of :multiplier }
    it { should allow_mass_assignment_of :statistic_id }
    it { should_not allow_mass_assignment_of :statistic }
    it { should_not allow_mass_assignment_of :gear_enhancements }
    it { should_not allow_mass_assignment_of :armors }
    it { should_not allow_mass_assignment_of :trinkets }
  end

  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should ensure_length_of(:name).is_at_most(32) }

    it { should validate_presence_of(:multiplier) }
    it { should validate_numericality_of(:multiplier) }
    # it { should validate_numericality_of(:level).greater_than(0) }

    it { should validate_presence_of(:statistic_id) }
  end

  it 'has a valid factory' do
    create(:enhancement).should be_valid
  end

  context 'is invalid if' do
    it 'multiplier is not greater than zero' do
      build(:enhancement, multiplier: 0).should_not be_valid
    end
  end
end
