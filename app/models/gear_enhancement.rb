class GearEnhancement < ActiveRecord::Base
  attr_accessible :rating, :enhancement_id

  belongs_to :enhancement

  # Polymorphic Associations
  belongs_to :gear, polymorphic: true

  # Validations
  validates :gear_type,
    presence: true
  validates :rating,
    presence: true,
    numericality: { only_integer: true, greater_than: 0 }

  validates_associated :enhancement
  validates_presence_of :enhancement_id

  # Overridden Methods
  def ==(other)
    return self.gear_type == other.gear_type && self.enhancement_id == other.enhancement_id && self.rating == other.rating
  end
end
