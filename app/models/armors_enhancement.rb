class ArmorsEnhancement < ActiveRecord::Base
  attr_accessible :rating

  belongs_to :armor
  belongs_to :enhancement

  validates :armor,
    presence: true
  validates :enhancement,
    presence: true
  validates :rating,
    presence: true,
    numericality: { only_integer: true, greater_than: 0 }
end
