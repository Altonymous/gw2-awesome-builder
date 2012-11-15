class GearOutfit < ActiveRecord::Base
  resourcify
  attr_accessible :outfit_id, :gear_id, :gear_type

  belongs_to :outfit

  belongs_to :gear, polymorphic: true

  validates :gear_type,
    presence: true
  validates :outfit_id,
    presence: true
end
