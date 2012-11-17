module StatisticModule
  STATISTIC = {
    armor: { id: 1, name: 'Armor' },
    attack_power: { id: 2, name: 'Attack Power' },
    hit_points: { id: 3, name: 'Hit Points' },
    healing_power: { id: 4, name: 'Healing Power' },
    condition_damage: { id: 5, name: 'Condition Damage' },
    critical_damage: { id: 6, name: 'Critical Damage' },
    critical_chance: { id: 7, name: 'Critical Chance' },
    condition_duration: { id: 8, name: 'Condition Duration' },
    boon_duration: { id: 9, name: 'Boon Duration' },
    magic_find: { id: 10, name: 'Magic Find' }
  }

  def self.statistics
    STATISTIC.keys
  end

  def self.find_by_statistic_id(statistic_id)
    STATISTIC.find{|key,value| value[:id] == statistic_id}.first
  end

  def generate_statistics
    StatisticModule::statistics.each do |statistic|
      write_attribute(statistic, 0)
    end

    self.gear_enhancements.each do |gear_enhancement|
      current_statistic = gear_enhancement.rating.zero? ?
        0 : gear_enhancement.rating * gear_enhancement.enhancement.multiplier

      statistic = StatisticModule::find_by_statistic_id(gear_enhancement.enhancement.statistic_id)
      write_attribute(statistic, read_attribute(statistic) + current_statistic.to_i)
    end
  end
end
