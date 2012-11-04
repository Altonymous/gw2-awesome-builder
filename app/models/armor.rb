class Armor < ActiveRecord::Base
  attr_accessible :name, :weight_id, :slot_id, :defense, :level

  belongs_to :weight
  belongs_to :slot

  has_many :gear_enhancements, as: :gear
  has_many :enhancements, through: :gear_enhancements

  # Validations
  validates :name,
    presence: true,
    uniqueness: true,
    length: { maximum: 48 }
  validates :weight,
    presence: true
  validates :slot,
    presence: true
  validates :defense,
    presence: true,
    numericality: { only_integer: true, greater_than: 0 }
  validates :level,
    presence: true,
    numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 80 }
  validates :gear_enhancements,
    presence: true
end
