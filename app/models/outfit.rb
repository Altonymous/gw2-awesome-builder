class Outfit < ActiveRecord::Base
  resourcify
  attr_accessible :suit_id, :jewelry_id

  before_save :generate_statistics

  belongs_to :suit
  belongs_to :jewelry

  # Validations
  validates :suit_id,
    presence: true
  validates_associated :suit
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
end
