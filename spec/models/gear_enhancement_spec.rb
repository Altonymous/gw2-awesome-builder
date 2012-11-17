require 'spec_helper'

describe GearEnhancement do
  context 'associations' do
    it { should belong_to :gear }
    it { should belong_to :enhancement }
  end

  context 'mass assignment' do
    it { should allow_mass_assignment_of :rating }
  end

  context 'validations' do
    it { should validate_presence_of(:gear_type) }

    it { should validate_presence_of(:rating) }
    it { should validate_numericality_of(:rating).only_integer }
    # it { should validate_numericality_of(:level).greater_than(0) }

    it { should validate_presence_of(:enhancement_id) }
  end

  context 'as an armor enhancement' do
    it 'has a valid factory' do
      create(:armor_enhancement).should be_valid
    end

    context 'is invalid if' do
      it 'rating is not greater than zero' do
        build(:armor_enhancement, rating: 0).should_not be_valid
      end
    end

    context 'check equality' do
      let(:enhancement1) { build(:gear_enhancement) }
      let(:enhancement2) { build(:gear_enhancement) }

      it { enhancement1.should == enhancement2 }

      context 'should not be equal' do
        it 'gear_type is different' do
          enhancement2.gear_type = 'Other'
          result = enhancement1 == enhancement2
          result.should be_false
        end

        it 'enhancement_id is different' do
          enhancement2.enhancement_id = enhancement1.enhancement_id + 1
          enhancement1.should_not == enhancement2
        end

        it 'rating is different' do
          enhancement2.rating = enhancement1.rating + 1
          enhancement1.should_not == enhancement2
        end
      end
    end
  end
end
