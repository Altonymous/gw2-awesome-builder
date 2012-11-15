class Armor < ActiveRecord::Base
  resourcify
  attr_accessible :name, :weight_id, :slot_id, :level, :gw2db_url, :icon_url

  after_initialize :defaults
  before_save :generate_statistics

  belongs_to :weight
  belongs_to :slot

  has_many :gear_enhancements, as: :gear
  has_many :enhancements, through: :gear_enhancements

  # Validations
  validates :name,
    presence: true,
    uniqueness: { scope: [:weight_id, :slot_id]},
    length: { maximum: 96 }
  validates :level,
    presence: true,
    numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 80 }

  validates_associated :weight
  validates_presence_of :weight_id
  validates_associated :slot
  validates_presence_of :slot_id
  validates_associated :gear_enhancements
  validates_presence_of :gear_enhancements

  # Scopes
  scope :light, where(weight_id: Weight.light.id) unless Weight.light.blank?
  scope :medium, where(weight_id: Weight.medium.id) unless Weight.medium.blank?
  scope :heavy, where(weight_id: Weight.heavy.id) unless Weight.heavy.blank?

  # Methods
  def generate_statistics
    statistics.each do |statistic|
      write_attribute(statistic, 0)
    end

    self.gear_enhancements.each do |gear_enhancement|
      current_statistic = gear_enhancement.rating.zero? ?
        0 : gear_enhancement.rating * gear_enhancement.enhancement.multiplier

      statistic = statistic_snake_name(Statistic.find(gear_enhancement.enhancement.statistic_id)).to_sym
      write_attribute(statistic, read_attribute(statistic) + current_statistic)
    end
  end

  private
  def defaults
    # Set statistics to zero
    statistics.each do |statistic|
      write_attribute(statistic, 0) if read_attribute(statistic).nil?
    end
  end

  include StatisticModule
end
