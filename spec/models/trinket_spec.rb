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

  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).scoped_to(:slot_id) }
    it { should ensure_length_of(:name).is_at_most(96) }

    it { should validate_presence_of(:level) }
    it { should validate_numericality_of(:level).only_integer }
    # it { should validate_numericality_of(:level).greater_than(0) }
    # it { should validate_numericality_of(:level).less_than_or_equal_to(80) }

    it { should validate_presence_of(:slot_id) }
  end

  it 'has a valid factory' do
    create(:armor).should be_valid
  end

  context 'is invalid if' do
    it 'level is not greater than zero' do
      build(:trinket, level: 0).should_not be_valid
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
