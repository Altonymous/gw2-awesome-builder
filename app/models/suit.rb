class Suit < ActiveRecord::Base
  resourcify
  before_save :generate_statistics

  # Associations
  has_many :outfits
  has_and_belongs_to_many :armors

  # Validations
  validates_presence_of :armors
  # validates_associated :armors

  # Scopes
  scope :light, joins(:armors).where(armors: { weight_id: WeightModule::WEIGHT[:light][:id] }).group('suits.id')
  scope :medium, joins(:armors).where(armors: { weight_id: WeightModule::WEIGHT[:medium][:id] }).group('suits.id')
  scope :heavy, joins(:armors).where(armors: { weight_id: WeightModule::WEIGHT[:heavy][:id] }).group('suits.id')

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
