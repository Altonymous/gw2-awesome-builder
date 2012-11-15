class Trinket < ActiveRecord::Base
  resourcify
  attr_accessible :name, :level, :slot_id, :gw2db_url, :icon_url

  after_initialize :defaults
  before_save :generate_statistics

  # Associations
  belongs_to :slot

  # Polymorphic Associations
  has_many :gear_enhancements, as: :gear
  has_many :enhancements, through: :gear_enhancements

  has_many :gear_outfits, as: :gear, :dependent => :destroy
  has_many :outfits, through: :gear_outfits

  # Validations
  validates :name,
    presence: true,
    uniqueness: true,
    length: { maximum: 96 }
  validates :level,
    presence: true,
    numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 80 }

  validates_associated :slot
  validates_presence_of :slot_id
  validates_associated :enhancements
  validates_associated :outfits

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
