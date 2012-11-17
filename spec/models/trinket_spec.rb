require 'spec_helper'

describe Trinket do
  context 'associations' do
    it { should belong_to :slot}
    it { should have_and_belong_to_many :jewelries }

    # Polymorphic Associations
    it { should have_many :gear_enhancements }
    it { should have_many :enhancements }
  end

  context 'mass assignment' do
    it { should allow_mass_assignment_of :name }
    it { should allow_mass_assignment_of :level }
    it { should allow_mass_assignment_of :slot_id }
    it { should allow_mass_assignment_of :gw2db_url }
    it { should allow_mass_assignment_of :icon_url }

    it { should_not allow_mass_assignment_of :slot }
    it { should_not allow_mass_assignment_of :jewelries }
    it { should_not allow_mass_assignment_of :gear_enhancements }
    it { should_not allow_mass_assignment_of :enhancements }
  end

  it 'has a valid factory' do
    create(:armor).should be_valid
  end

  context 'is invalid without' do
    it 'a name' do
      build(:trinket, name: nil).should_not be_valid
    end

    it 'a level' do
      build(:trinket, level: nil).should_not be_valid
    end

    it 'a slot' do
      build(:trinket, slot: nil).should_not be_valid
    end
  end

  context 'is invalid if' do
    it 'name already exists' do
      create(:trinket, name: "Trinket")
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

  context '#generate_statistics' do
    subject { trinket }

    let(:trinket) { create(:trinket, :with_all_enhancements, :rating => 10) }

    it { subject.armor.should equal(20) }
    it { subject.hit_points.should equal(100) }
    it { subject.attack_power.should equal(10) }
    it { subject.critical_damage.should equal(10) }
    it { subject.critical_chance.should equal(0) }
    it { subject.condition_damage.should equal(10) }
    it { subject.condition_duration.should equal(10) }
    it { subject.healing_power.should equal(10) }
    it { subject.boon_duration.should equal(10) }
    it { subject.magic_find.should equal(10) }
  end
end
