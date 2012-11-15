require 'spec_helper'

describe GearOutfit do
  context 'associations' do
    it { should belong_to :gear }
    it { should belong_to :outfit }
  end

  context 'mass assignement' do
    it { should allow_mass_assignment_of :outfit_id }
    it { should allow_mass_assignment_of :gear_id }
    it { should allow_mass_assignment_of :gear_type }
  end

  context 'as an helm piece' do
    it 'has a valid factory' do
      create(:gear_outfit, :helm).should be_valid
    end

    context 'is invalid without' do
      it 'a helm' do
        build(:gear_outfit).should_not be_valid
      end

      it 'an outfit' do
        build(:gear_outfit, outfit_id: nil).should_not be_valid
      end

      it 'a gear type' do
        build(:gear_outfit, :helm, gear_type: nil).should_not be_valid
      end
    end
  end
end
