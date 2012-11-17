class Suit < ActiveRecord::Base
  resourcify
  before_save :generate_statistics

  # Associations
  has_many :outfits
  has_and_belongs_to_many :armors

  # Validations
  validates_associated :armors

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
end
