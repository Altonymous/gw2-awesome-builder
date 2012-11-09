class Trinket < ActiveRecord::Base
  attr_accessible :name, :level, :slot_id

  belongs_to :slot

  has_many :gear_enhancements, as: :gear
  has_many :enhancements, through: :gear_enhancements

  # Validations
  validates :name,
    presence: true,
    uniqueness: true,
    length: { maximum: 48 }
  validates :slot,
    presence: true
  validates :level,
    presence: true,
    numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 80 }
  validates :gear_enhancements,
    presence: true

  include StatisticModule

  def pieces
    nil
  end
end
