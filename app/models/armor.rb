class Armor < ActiveRecord::Base
  resourcify
  attr_accessible :name, :level, :slot_id, :weight_id, :gw2db_url, :icon_url

  before_validation :generate_statistics

  # Associations
  belongs_to :weight
  belongs_to :slot
  has_and_belongs_to_many :suits

  # Polymorphic Associations
  has_many :gear_enhancements, as: :gear, :dependent => :destroy
  has_many :enhancements, through: :gear_enhancements

  # Validations
  validates :name,
    presence: true,
    uniqueness: { scope: [:weight_id, :slot_id] },
    length: { maximum: 96 }
  validates :level,
    presence: true,
    numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 80 }
  validates :weight_id,
    presence: true
  validates :slot_id,
    presence: true
  validates_associated :gear_enhancements

  # Scopes
  scope :helm, where(slot_id: SlotModule::SLOT[:helm][:id])
  scope :shoulders, where(slot_id: SlotModule::SLOT[:shoulders][:id])
  scope :coats, where(slot_id: SlotModule::SLOT[:coat][:id])
  scope :gloves, where(slot_id: SlotModule::SLOT[:gloves][:id])
  scope :legs, where(slot_id: SlotModule::SLOT[:legs][:id])
  scope :boots, where(slot_id: SlotModule::SLOT[:boots][:id])

  scope :light, where(weight_id: WeightModule::WEIGHT[:light][:id])
  scope :medium, where(weight_id: WeightModule::WEIGHT[:medium][:id])
  scope :heavy, where(weight_id: WeightModule::WEIGHT[:heavy][:id])

  # Includes
  include StatisticModule
end
