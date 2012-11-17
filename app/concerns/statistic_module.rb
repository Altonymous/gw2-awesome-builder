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
    STATISTIC.key(statistic_id)
  end
end
