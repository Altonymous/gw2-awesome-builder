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

  it 'has a valid factory' do
    create(:enhancement).should be_valid
  end

  context 'is invalid without' do
    it 'a name' do
      build(:enhancement, name: nil).should_not be_valid
    end

    it 'a multiplier' do
      build(:enhancement, multiplier: nil).should_not be_valid
    end

    it 'a statistic' do
      build(:enhancement, statistic: nil).should_not be_valid
    end
  end

  context 'is invalid if' do
    it 'name already exists' do
      create(:enhancement, name: "Enhancement")
      build(:enhancement, name: "Enhancement").should_not be_valid
    end

    it 'name is longer than 32 characters' do
      build(:enhancement, name: "name".rjust(33, "0")).should_not be_valid
    end

    it 'multiplier is not a number' do
      build(:enhancement, multiplier: "Test").should_not be_valid
    end

    it 'multiplier is not greater than zero' do
      build(:enhancement, multiplier: 0).should_not be_valid
    end
  end
end
