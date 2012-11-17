module EnhancementModule
  ENHANCEMENT = {
    power: { id: 1, name: 'Power', multiplier: 1, statistic_id: StatisticModule::STATISTIC[:attack_power][:id] },
    precision: { id: 2, name: 'Precision', multiplier: 0.04761904761905, statistic_id: StatisticModule::STATISTIC[:critical_chance][:id] },
    toughness: { id: 3, name: 'Toughness', multiplier: 1, statistic_id: StatisticModule::STATISTIC[:armor][:id] },
    defense: { id: 4, name: 'Defense', multiplier: 1, statistic_id: StatisticModule::STATISTIC[:armor][:id] },
    vitality: { id: 5, name: 'Vitality', multiplier: 10, statistic_id: StatisticModule::STATISTIC[:hit_points][:id] },
    critical_damage: { id: 6, name: 'Critical Damage', multiplier: 1, statistic_id: StatisticModule::STATISTIC[:critical_damage][:id] },
    condition_damage: { id: 7, name: 'Condition Damage', multiplier: 1, statistic_id: StatisticModule::STATISTIC[:condition_damage][:id] },
    healing_power: { id: 8, name: 'Healing Power', multiplier: 1, statistic_id: StatisticModule::STATISTIC[:healing_power][:id] },
    condition_duration: { id: 9, name: 'Condition Duration', multiplier: 1, statistic_id: StatisticModule::STATISTIC[:condition_duration][:id] },
    boon_duration: { id: 10, name: 'Boon Duration', multiplier: 1, statistic_id: StatisticModule::STATISTIC[:boon_duration][:id] },
    magic_find: { id: 11, name: 'Magic Find', multiplier: 1, statistic_id: StatisticModule::STATISTIC[:magic_find][:id] }
  }

  def self.enhancements
    ENHANCEMENT.keys
  end

  def self.find_by_enhancement_id(enhancement_id)
    ENHANCEMENT.find{|key,value| value[:id] == enhancement_id}.first
  end
end
