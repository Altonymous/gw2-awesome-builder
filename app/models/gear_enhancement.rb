class GearEnhancement < ActiveRecord::Base
  resourcify
  attr_accessible :rating, :enhancement_id, :gear_id, :gear_type

  belongs_to :enhancement

  # Polymorphic Associations
  belongs_to :gear, polymorphic: true

  # Validations
  validates :gear_type,
    presence: true
  validates :rating,
    presence: true,
    numericality: { only_integer: true, greater_than: 0 }
  validates :enhancement_id,
    presence: true

  # Overridden Methods
  def ==(other)
    return self.gear_type == other.gear_type && self.enhancement_id == other.enhancement_id && self.rating == other.rating
  end
end
