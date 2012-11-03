require 'spec_helper'

describe Statistic do
  describe 'mass assignment' do
    it { should allow_mass_assignment_of :name }
    it { should allow_mass_assignment_of :kind }
    it { should allow_mass_assignment_of :minimum }
    it { should allow_mass_assignment_of :maximum }
    it { should allow_mass_assignment_of :interval }
  end

  it 'has a valid factory' do
    create(:statistic).should be_valid
  end

  context 'is invalid without' do
    it 'a name' do
      build(:statistic, name: nil).should_not be_valid
    end

    it 'a kind' do
      build(:statistic, kind: nil).should_not be_valid
    end

    it 'a minimum' do
      stat = build(:statistic, minimum: nil)
      stat.should_not be_valid
    end

    it 'a maximum' do
      build(:statistic, maximum: nil).should_not be_valid
    end

    it 'an interval' do
      build(:statistic, interval: nil).should_not be_valid
    end
  end

  context 'is invalid if' do
    it 'name already exists' do
      statistic = create(:statistic, name: "Statistic")
      build(:statistic, name: "Statistic").should_not be_valid
    end

    it 'name is longer than 36 characters' do
      build(:statistic, name: "name".rjust(37, "0")).should_not be_valid
    end

    it 'kind is longer than 12 characters' do
      build(:statistic, kind: "kind".rjust(13, "0")).should_not be_valid
    end

    it 'maximum is equal to minimum' do
      build(:statistic, maximum: 10, minimum: 10).should_not be_valid
    end

    it 'maximum is not greater than minimum' do
      build(:statistic, maximum: 1, minimum: 2).should_not be_valid
    end

    it 'the maximum is not equally divisible by the interval' do
      build(:statistic, maximum: 20, interval: 3).should_not be_valid
    end

    it 'minimum is not an integer' do
      build(:statistic, minimum: "Test").should_not be_valid
    end

    it 'maximum is not an integer' do
      build(:statistic, maximum: "Test").should_not be_valid
    end

    it 'interval is not an integer' do
      build(:statistic, interval: "Test").should_not be_valid
    end
  end
end
