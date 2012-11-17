class Trinket < ActiveRecord::Base
  resourcify
  attr_accessible :name, :level, :slot_id, :gw2db_url, :icon_url

  before_validation :generate_statistics

  # Associations
  belongs_to :slot
  has_and_belongs_to_many :jewelries

  # Polymorphic Associations
  has_many :gear_enhancements, as: :gear, :dependent => :destroy
  has_many :enhancements, through: :gear_enhancements

  # Validations
  validates :name,
    presence: true,
    uniqueness: { scope: [:slot_id] },
    length: { maximum: 96 }
  validates :level,
    presence: true,
    numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 80 }
  validates :slot_id,
    presence: true
  validates_associated :gear_enhancements
  validates_presence_of :gear_enhancements

  # Scopes
  scope :rings, where(slot_id: SlotModule::SLOT[:ring][:id])
  scope :accessories, where(slot_id: SlotModule::SLOT[:accessory][:id])
  scope :amulets, where(slot_id: SlotModule::SLOT[:amulet][:id])

  # Includes
  include StatisticModule
end
