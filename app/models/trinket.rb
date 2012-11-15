class Trinket < ActiveRecord::Base
  resourcify
  attr_accessible :name, :level, :slot_id

  after_initialize :defaults
  before_save :generate_statistics

  belongs_to :slot

  has_many :gear_enhancements, as: :gear
  has_many :enhancements, through: :gear_enhancements

  # Validations
  validates :name,
    presence: true,
    uniqueness: true,
    length: { maximum: 48 }
  validates :level,
    presence: true,
    numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 80 }

  validates_associated :slot
  validates_presence_of :slot_id
  validates_associated :gear_enhancements
  validates_presence_of :gear_enhancements

  # Methods
  def generate_statistics
    StatisticModule::statistics.each do |statistic|
      write_attribute(statistic, 0)
    end

    self.gear_enhancements.each do |gear_enhancement|
      current_statistic = gear_enhancement.rating.zero? ?
        0 : gear_enhancement.rating + gear_enhancement.enhancement.multiplier

      statistic = StatisticModule::find_by_statistic_id(gear_enhancement.enhancement.statistic_id)
      write_attribute(statistic, read_attribute(statistic) + current_statistic)
    end
  end

  private
  def defaults
    # Set statistics to zero
    StatisticModule::statistics.each do |statistic|
      write_attribute(statistic, 0) if read_attribute(statistic).nil?
    end
  end

  # include StatisticModule
end
