module StatisticModule
  STATISTIC = {
    armor: 1,
    attack_power: 2,
    hit_points: 3,
    healing_power: 4,
    condition_damage: 5,
    critical_damage: 6,
    critical_chance: 7,
    condition_duration: 8,
    boon_duration: 9
  }

  def self.statistics
    STATISTIC.keys
  end

  def self.find_by_statistic_id(statistic_id)
    STATISTIC.key(statistic_id)
  end
end
