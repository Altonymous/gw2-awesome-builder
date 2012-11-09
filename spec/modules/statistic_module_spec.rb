require 'spec_helper'

shared_examples_for StatisticModule do
  context "class methods" do
    it 'should be able to get the attack power' do
      pending "Figure out how to test metaprogrammed methods that are mixedin."
      described_class.attack_power.should_not be_empty
    end
  end
end

describe Armor do
  it_behaves_like StatisticModule
end

describe Outfit do
  it_behaves_like StatisticModule
end
