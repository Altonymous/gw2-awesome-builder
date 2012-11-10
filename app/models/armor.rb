class Armor < ActiveRecord::Base
  attr_accessible :name, :weight_id, :slot_id, :level
  after_initialize :defaults
  before_create :generate_statistics

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
  validates :level,
    presence: true,
    numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 80 }
  validates :gear_enhancements,
    presence: true

  scope :light, where(weight_id: Weight.light.id)
  scope :medium, where(weight_id: Weight.medium.id)
  scope :heavy, where(weight_id: Weight.heavy.id)

  def generate_statistics
    self.gear_enhancements.each do |gear_enhancement|
      current_statistic = gear_enhancement.rating.zero? ?
        0 : gear_enhancement.rating + gear_enhancement.enhancement.multiplier

      statistic = statistic_snake_name(gear_enhancement.enhancement.statistic).to_sym
      self[statistic] = self[statistic] + current_statistic
    end
  end

  private
  def defaults
    # Set statistics to zero
    Statistic.all.each do |statistic_model|
      statistic = statistic_snake_name(statistic_model).to_sym

      self[statistic] ||= 0
    end
  end

  include StatisticModule
end
