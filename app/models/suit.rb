class Suit < ActiveRecord::Base
  resourcify
  before_save :generate_statistics

  # Associations
  belongs_to :weight

  has_many :outfits
  has_and_belongs_to_many :armors

  # Validations
  validates_presence_of :armors
  # validates_associated :armors

  # Scopes
  scope :light, where(weight_id: WeightModule::WEIGHT[:light][:id])
  scope :medium, where(weight_id: WeightModule::WEIGHT[:medium][:id])
  scope :heavy, where(weight_id: WeightModule::WEIGHT[:heavy][:id])

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
