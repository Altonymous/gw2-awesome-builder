require 'spec_helper'

describe Statistic do
  context 'associations' do
    it { should have_many :enhancements }
  end

  context 'mass assignment' do
    it { should allow_mass_assignment_of :name }
  end

  it 'has a valid factory' do
    create(:statistic).should be_valid
  end

  context 'is invalid without' do
    it 'a name' do
      build(:statistic, name: nil).should_not be_valid
    end
  end

  context 'is invalid if' do
    it 'name already exists' do
      create(:statistic, name: "Statistic")
      build(:statistic, name: "Statistic").should_not be_valid
    end

    it 'name is longer than 36 characters' do
      build(:statistic, name: "name".rjust(37, "0")).should_not be_valid
    end
  end
end
