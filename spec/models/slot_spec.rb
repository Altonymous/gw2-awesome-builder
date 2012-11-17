require 'spec_helper'

describe Slot do
  context 'associations' do
    it { should have_many :armors }
  end

  context 'mass assignment' do
    it { should allow_mass_assignment_of :name }
    it { should allow_mass_assignment_of :slot_type }
    it { should_not allow_mass_assignment_of :armors }
  end

  it 'has a valid factory' do
    create(:slot).should be_valid
  end

  context 'is invalid without' do
    it 'a name' do
      build(:slot, name: nil).should_not be_valid
    end
    it 'a slot_type' do
      build(:slot, slot_type: nil).should_not be_valid
    end
  end

  context 'is invalid if' do
    it 'name already exists' do
      create(:slot, name: "Slot")
      build(:slot, name: "Slot").should_not be_valid
    end

    it 'name is longer than 32 characters' do
      build(:slot, name: "name".rjust(33, "'")).should_not be_valid
    end

    it 'slot_type is longer than 16 characters' do
      build(:slot, slot_type: "slot_type".rjust(17, "'")).should_not be_valid
    end
  end
end
