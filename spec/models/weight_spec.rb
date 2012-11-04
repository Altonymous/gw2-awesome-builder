require 'spec_helper'

describe Weight do
  context 'associations' do
    it { should have_many :armors }
  end

  context 'mass assignment' do
    it { should allow_mass_assignment_of :name }
    it { should_not allow_mass_assignment_of :armors }
  end

  it 'has a valid factory' do
    create(:weight).should be_valid
  end

  context 'is invalid without' do
    it 'a name' do
      build(:weight, name: nil).should_not be_valid
    end
  end

  context 'is invalid if' do
    it 'name already exists' do
      create(:weight, name: "Weight")
      build(:weight, name: "Weight").should_not be_valid
    end

    it 'name is longer than 16 characters' do
      build(:weight, name: "name".rjust(17, "'")).should_not be_valid
    end
  end
end
