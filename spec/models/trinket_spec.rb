require 'spec_helper'

describe Trinket do
  context 'associations' do
    it { should belong_to :slot}
    it { should have_many :gear_enhancements }
    it { should have_many :enhancements }
  end

  context 'mass assignment' do
    it { should allow_mass_assignment_of :name }
    it { should allow_mass_assignment_of :slot_id }
    it { should allow_mass_assignment_of :level }
    it { should_not allow_mass_assignment_of :slot }
    it { should_not allow_mass_assignment_of :gear_enhancements }
    it { should_not allow_mass_assignment_of :enhancements }
  end

  it 'has a valid factory' do
    create(:armor, :with_enhancement).should be_valid
  end

  context 'is invalid without' do
    it 'a name' do
      build(:trinket, name: nil).should_not be_valid
    end

    it 'a slot' do
      build(:trinket, slot: nil).should_not be_valid
    end

    it 'a level' do
      build(:trinket, level: nil).should_not be_valid
    end
  end

  context 'is invalid if' do
    it 'name already exists' do
      create(:trinket, :with_enhancement, name: "Trinket")
      build(:trinket, name: "Trinket").should_not be_valid
    end

    it 'name is longer than 48 characters' do
      build(:trinket, name: "name".rjust(97, "0")).should_not be_valid
    end

    it 'level is not a number' do
      build(:trinket, level: "Test").should_not be_valid
    end

    it 'level is not greater than zero' do
      build(:trinket, level: 0).should_not be_valid
    end

    it 'level is not an integer' do
      build(:trinket, level: 1.1).should_not be_valid
    end

    it 'level is not less than or equal to eighty' do
      build(:trinket, level: 81).should_not be_valid
    end
  end
end
