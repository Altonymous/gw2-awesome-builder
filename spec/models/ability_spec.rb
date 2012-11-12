require 'spec_helper'

describe Ability do
  subject { ability }

  let(:ability) { Ability.new(user) }

  context 'when administrator' do
    let(:user) { create(:user, :administrator) }

    it { should be_able_to(:destroy, build(:slot)) }
  end

  context 'user' do
    let(:user) { create(:user) }

    it { should_not be_able_to(:destroy, build(:slot)) }
  end
end