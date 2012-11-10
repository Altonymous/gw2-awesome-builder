class Outfit < ActiveRecord::Base
  attr_accessible :arms_id, :chest_id, :feet_id, :head_id, :legs_id, :shoulders_id
  after_initialize :defaults
  # before_save :generate_statistics

  belongs_to :head, class_name: :Armor
  belongs_to :shoulders, class_name: :Armor
  belongs_to :chest, class_name: :Armor
  belongs_to :arms, class_name: :Armor
  belongs_to :legs, class_name: :Armor
  belongs_to :feet, class_name: :Armor

  def self.test1
    outfits = Outfit.limit(100).order('id asc')
    outfits.map {|outfit| outfit.generate_statistics}
  end

  def self.test2
    outfits = Outfit.limit(100).order('id asc')
    outfits.map {|outfit| outfit.gen_stats}
  end

  def generate_statistics
    %w(arms chest feet head legs shoulders).each do |piece|
      self.send(piece.to_sym).gear_enhancements.each do |gear_enhancement|
        current_statistic = gear_enhancement.rating.zero? ?
          0 : gear_enhancement.rating + gear_enhancement.enhancement.multiplier

        statistic = statistic_snake_name(gear_enhancement.enhancement.statistic).to_sym
        self[statistic] = self[statistic] + current_statistic
      end
    end

    Statistic.all.each do |statistic_model|
      statistic = statistic_snake_name(statistic_model).to_sym

      %w(arms chest feet head legs shoulders).each do |piece|
        self[statistic] = self[statistic] + self.send(piece.to_sym)[statistic]
      end
    end
  end

  private
  def defaults
    # Set statistics to zero
    Statistic.all.each do |statistic_model|
      statistic = statistic_snake_name(statistic_model).to_sym

      self[statistic] ||= 0
    end
  end

  include StatisticModule
end
