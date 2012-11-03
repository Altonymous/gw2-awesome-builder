class ArmorsEnhancement < ActiveRecord::Base
  attr_accessible :rating

  belongs_to :armor
  belongs_to :enhancement
end
