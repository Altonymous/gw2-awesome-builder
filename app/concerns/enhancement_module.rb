module EnhancementModule
  ENHANCEMENT = {
    power: 1,
    precision: 2,
    toughness: 3,
    defense: 4,
    vitality: 5,
    critical_damage: 6,
    condition_damage: 7,
    healing_power: 8,
    condition_duration: 9,
    boon_duration: 10
  }

  def self.enhancements
    ENHANCEMENT.keys
  end

  def self.find_by_enhancement_id(enhancement_id)
    ENHANCEMENT.key(enhancement_id)
  end
end
