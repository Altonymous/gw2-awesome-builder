require 'spec_helper'

describe Outfit do
  context 'associations' do
    it { should belong_to :helm }
    it { should belong_to :shoulders }
    it { should belong_to :coat }
    it { should belong_to :gloves }
    it { should belong_to :legs }
    it { should belong_to :boots }
  end

  context 'mass assignment' do
    it { should allow_mass_assignment_of :helm_id }
    it { should allow_mass_assignment_of :shoulders_id }
    it { should allow_mass_assignment_of :coat_id }
    it { should allow_mass_assignment_of :gloves_id }
    it { should allow_mass_assignment_of :legs_id }
    it { should allow_mass_assignment_of :boots_id }
  end

  it 'has a valid factory' do
    create(:outfit).should be_valid
  end

  context 'is invalid without' do
    it 'armor' do
      build(:outfit, armor: nil).should_not be_valid
    end

    it 'attack power' do
      build(:outfit, attack_power: nil).should_not be_valid
    end

    it 'hit_points' do
      build(:outfit, hit_points: nil).should_not be_valid
    end

    it 'critical_chance' do
      build(:outfit, critical_chance: nil).should_not be_valid
    end

    it 'critical_damage' do
      build(:outfit, critical_damage: nil).should_not be_valid
    end

    it 'condition_damage' do
      build(:outfit, condition_damage: nil).should_not be_valid
    end

    it 'condition_duration' do
      build(:outfit, condition_duration: nil).should_not be_valid
    end

    it 'healing_power' do
      build(:outfit, healing_power: nil).should_not be_valid
    end

    it 'boon_duration' do
      build(:outfit, boon_duration: nil).should_not be_valid
    end

    it 'a helm piece' do
      build(:outfit, helm_id: nil).should_not be_valid
    end

    it 'a shoulders piece' do
      build(:outfit, shoulders_id: nil).should_not be_valid
    end

    it 'a coat piece' do
      build(:outfit, coat_id: nil).should_not be_valid
    end

    it 'a gloves piece' do
      build(:outfit, gloves_id: nil).should_not be_valid
    end

    it 'a legs piece' do
      build(:outfit, legs_id: nil).should_not be_valid
    end

    it 'a boots piece' do
      build(:outfit, boots_id: nil).should_not be_valid
    end
  end

  context 'is invalid if' do
    it 'armor is not a number' do
      build(:outfit, armor: "Test").should_not be_valid
    end

    it 'armor is not greater than or equal to zero' do
      build(:outfit, armor: -1).should_not be_valid
    end

    it 'attack_power is not a number' do
      build(:outfit, attack_power: "Test").should_not be_valid
    end

    it 'attack_power is not greater than or equal to zero' do
      build(:outfit, attack_power: -1).should_not be_valid
    end

    it 'hit_points is not a number' do
      build(:outfit, hit_points: "Test").should_not be_valid
    end

    it 'hit_points is not greater than or equal to zero' do
      build(:outfit, hit_points: -1).should_not be_valid
    end

    it 'critical_chance is not a number' do
      build(:outfit, critical_chance: "Test").should_not be_valid
    end

    it 'critical_chance is not greater than or equal to zero' do
      build(:outfit, critical_chance: -1).should_not be_valid
    end

    it 'critical_damage is not a number' do
      build(:outfit, critical_damage: "Test").should_not be_valid
    end

    it 'critical_damage is not greater than or equal to zero' do
      build(:outfit, critical_damage: -1).should_not be_valid
    end

    it 'condition_damage is not a number' do
      build(:outfit, condition_damage: "Test").should_not be_valid
    end

    it 'condition_damage is not greater than or equal to zero' do
      build(:outfit, condition_damage: -1).should_not be_valid
    end

    it 'condition_duration is not a number' do
      build(:outfit, condition_duration: "Test").should_not be_valid
    end

    it 'condition_duration is not greater than or equal to zero' do
      build(:outfit, condition_duration: -1).should_not be_valid
    end

    it 'healing_power is not a number' do
      build(:outfit, healing_power: "Test").should_not be_valid
    end

    it 'healing_power is not greater than or equal to zero' do
      build(:outfit, healing_power: -1).should_not be_valid
    end

    it 'boon_duration is not a number' do
      build(:outfit, boon_duration: "Test").should_not be_valid
    end

    it 'boon_duration is not greater than or equal to zero' do
      build(:outfit, boon_duration: -1).should_not be_valid
    end
  end
end
