class Outfit < ActiveRecord::Base
  resourcify
  attr_accessible :suit_id, :jewelry_id, :weight_id

  before_save :generate_statistics

  belongs_to :weight
  belongs_to :suit
  belongs_to :jewelry

  # Validations
  validates :weight_id,
    presence: true
  validates :weight,
    presence: true
  validates :weight,
    associated: true

  validates :suit_id,
    presence: true
  validates :suit,
    presence: true
  validates :suit,
    associated: true

  validates :jewelry_id,
    presence: true
  validates :jewelry,
    presence: true
  validates :jewelry,
    associated: true

  # Methods
  def generate_statistics
    StatisticModule::statistics.each do |statistic|
      # Set the statistic to 0 before we recalculate
      write_attribute(statistic, 0)

      write_attribute(statistic, read_attribute(statistic) + suit[statistic])
      write_attribute(statistic, read_attribute(statistic) + jewelry[statistic])
    end
  end

  # Overridden Methods
  def ==(other)
    return false unless self.weight_id == other.weight_id

    StatisticModule::statistics.each do |statistic|
      return false unless read_attribute(statistic) == other[statistic]
    end

    return true
  end
  alias :eql? :==
end
