require 'spec_helper'

describe Armor do
  context 'associations' do
    it { should belong_to :weight }
    it { should belong_to :slot}
    it { should have_many :gear_enhancements }
    it { should have_many :enhancements }
  end

  context 'mass assignment' do
    it { should allow_mass_assignment_of :name }
    it { should allow_mass_assignment_of :weight_id }
    it { should allow_mass_assignment_of :slot_id }
    it { should allow_mass_assignment_of :level }
    it { should_not allow_mass_assignment_of :weight }
    it { should_not allow_mass_assignment_of :slot }
    it { should_not allow_mass_assignment_of :gear_enhancements }
    it { should_not allow_mass_assignment_of :enhancements }
  end

  it 'has a valid factory' do
    create(:armor, :with_enhancement).should be_valid
  end

  context 'is invalid without' do
    it 'a name' do
      build(:armor, name: nil).should_not be_valid
    end

    it 'a weight' do
      build(:armor, weight: nil).should_not be_valid
    end

    it 'a slot' do
      build(:armor, slot: nil).should_not be_valid
    end

    it 'a level' do
      build(:armor, level: nil).should_not be_valid
    end

    it 'a gear enhancement is not defined' do
      armor = build(:armor)
      armor.gear_enhancements = []
      armor.should_not be_valid
    end
  end

  context 'is invalid if' do
    it 'name already exists' do
      create(:armor, :with_enhancement, name: "Armor")
      build(:armor, :with_enhancement, name: "Armor").should_not be_valid
    end

    it 'name is longer than 96 characters' do
      build(:armor, name: "name".rjust(97, "0")).should_not be_valid
    end

    it 'level is not a number' do
      build(:armor, level: "Test").should_not be_valid
    end

    it 'level is not greater than zero' do
      build(:armor, level: 0).should_not be_valid
    end

    it 'level is not an integer' do
      build(:armor, level: 1.1).should_not be_valid
    end

    it 'level is not less than or equal to eighty' do
      build(:armor, level: 81).should_not be_valid
    end
  end

  context '#generate_statistics' do
    subject { gear }

    let(:gear) { create(:armor, :with_all_enhancements, :rating => 10) }

    it { subject.armor.should equal(22) }
    it { subject.hit_points.should equal(20) }
    it { subject.attack_power.should equal(11) }
    it { subject.critical_damage.should equal(11) }
    it { subject.critical_chance.should equal(10) }
    it { subject.condition_damage.should equal(11) }
    it { subject.condition_duration.should equal(11) }
    it { subject.healing_power.should equal(11) }
    it { subject.boon_duration.should equal(11) }
  end
end
