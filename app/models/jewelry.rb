class Jewelry < ActiveRecord::Base
  resourcify
  before_save :generate_statistics

  # Associations
  has_many :outfits
  has_and_belongs_to_many :trinkets

  # Validations
  validates_presence_of :trinkets
  validates_associated :trinkets

  # Methods
  def generate_statistics
    StatisticModule::statistics.each do |statistic|
      # Set the statistic to 0 before we recalculate
      write_attribute(statistic, 0)

      trinkets.each do |trinket|
        write_attribute(statistic, read_attribute(statistic) + trinket[statistic])
      end
    end
  end
end
