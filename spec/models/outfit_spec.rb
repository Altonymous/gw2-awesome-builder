require 'spec_helper'

describe Outfit do
  context 'associations' do
    it { should belong_to :head }
    it { should belong_to :shoulders }
    it { should belong_to :chest }
    it { should belong_to :arms }
    it { should belong_to :legs }
    it { should belong_to :feet }
  end

  context 'mass assignment' do
    it { should allow_mass_assignment_of :arms_id }
    it { should allow_mass_assignment_of :shoulders_id }
    it { should allow_mass_assignment_of :chest_id }
    it { should allow_mass_assignment_of :arms_id }
    it { should allow_mass_assignment_of :legs_id }
    it { should allow_mass_assignment_of :feet_id }
  end

  context '#pieces' do
    it { subject.pieces.should =~ %w(arms chest feet head legs shoulders) }
  end

  context '#meta_methods' do
    it { subject.attack_power.should be_valid }
  end
end
