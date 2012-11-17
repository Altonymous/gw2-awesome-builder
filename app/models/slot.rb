class Slot < ActiveRecord::Base
  resourcify
  attr_accessible :name, :slot_type

  has_many :armors

  validates :name,
    presence:true,
    uniqueness: true,
    length: { maximum: 32 }
  validates :slot_type,
    presence: true,
    length: { maximum: 16 }
end
