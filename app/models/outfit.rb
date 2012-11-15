class Outfit < ActiveRecord::Base
  resourcify
  attr_accessible :gloves_id, :coat_id, :boots_id, :helm_id, :legs_id, :shoulders_id,
    :gloves, :coat, :boots, :helm, :legs, :shoulders
  after_initialize :defaults
  before_save :generate_statistics

  belongs_to :helm, class_name: :Armor
  belongs_to :shoulders, class_name: :Armor
  belongs_to :coat, class_name: :Armor
  belongs_to :gloves, class_name: :Armor
  belongs_to :legs, class_name: :Armor
  belongs_to :boots, class_name: :Armor

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

  validates_associated :helm
  validates_presence_of :helm_id
  validates_associated :shoulders
  validates_presence_of :shoulders_id
  validates_associated :coat
  validates_presence_of :coat_id
  validates_associated :gloves
  validates_presence_of :gloves_id
  validates_associated :legs
  validates_presence_of :legs_id
  validates_associated :boots
  validates_presence_of :boots_id

  def generate_statistics
    Statistic.all.each do |statistic_model|
      statistic = statistic_snake_name(statistic_model).to_sym

      %w(gloves coat boots helm legs shoulders).each do |piece|
        write_attribute(statistic, read_attribute(statistic) + self.send(piece.to_sym)[statistic])
      end
    end
  end

  private
  def defaults
    # Set statistics to zero
    Statistic.all.each do |statistic_model|
      statistic = statistic_snake_name(statistic_model).to_sym

      write_attribute(statistic, 0) if read_attribute(statistic).nil?
    end
  end

  include StatisticModule
end
