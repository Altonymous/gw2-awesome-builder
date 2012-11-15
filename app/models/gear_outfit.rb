class GearOutfit < ActiveRecord::Base
  resourcify
  attr_accessible :outfit_id, :gear_id, :gear_type

  # Associations
  belongs_to :outfit

  # Polymorphic Associations
  belongs_to :gear, polymorphic: true

  # Validations
  validates :gear_type,
    presence: true
  validates :outfit_id,
    presence: true
end
