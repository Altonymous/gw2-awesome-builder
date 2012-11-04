class GearEnhancement < ActiveRecord::Base
  attr_accessible :rating, :enhancement_id

  belongs_to :enhancement

  # Polymorphic Associations
  belongs_to :gear, polymorphic: true

  validates :enhancement,
    presence: true
  validates :gear_type,
    presence: true
  validates :rating,
    presence: true,
    numericality: { only_integer: true, greater_than: 0 }
end
