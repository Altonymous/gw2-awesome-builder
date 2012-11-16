class Outfit < ActiveRecord::Base
  resourcify
  after_initialize :defaults
  before_save :generate_statistics, if: blah?

  # Polymorphic Associations
  has_many :gear_outfits, :dependent => :destroy
  has_many :armors, through: :gear_outfits, source: :gear, source_type: 'Armor'
  has_many :trinkets, through: :gear_outfits, source: :gear, source_type: 'Trinket'

  # Validations
  validates :armor,
    presence: true,
    numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validates :attack_power,
    presence: true,
    numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validates :hit_points,
    presence: true,
    numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validates :critical_chance,
    presence: true,
    numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validates :critical_damage,
    presence: true,
    numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validates :condition_damage,
    presence: true,
    numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validates :condition_duration,
    presence: true,
    numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validates :healing_power,
    presence: true,
    numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validates :boon_duration,
    presence: true,
    numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  # Methods
  def generate_statistics
    StatisticModule::statistics.each do |statistic|
      # Set the statistic to 0 before we recalculate
      write_attribute(statistic, 0)

      armors.each do |armor|
        write_attribute(statistic, read_attribute(statistic) + armor[statistic])
      end
    end
  end

  private
  def defaults
    # Set statistics to zero
    StatisticModule::statistics.each do |statistic|
      write_attribute(statistic, 0) if read_attribute(statistic).nil?
    end
  end

  include StatisticModule
  include GearModule
end
