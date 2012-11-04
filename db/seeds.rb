puts 'STARTING SEED'

puts 'CREATING ROLES'
Role.create!([
               { name: 'administrator' },
               { name: 'user' }
], without_protection: true)

puts 'CREATING STATISTICS'
Statistic.create!([
                    { name: 'Armor', kind: 'numeric', minimum: 0, maximum: 3000, interval: 10 },
                    { name: 'Attack Power', kind: 'numeric', minimum: 0, maximum: 3000, interval: 10 },
                    { name: 'Hit Points', kind: 'numeric', minimum: 0, maximum: 60000, interval: 100 },
                    { name: 'Healing Power', kind: 'numeric', minimum: 0, maximum: 3000, interval: 10 },
                    { name: 'Condition Damage', kind: 'numeric', minimum: 0, maximum: 3000, interval: 10 },
                    { name: 'Critical Damage', kind: 'numeric', minimum: 0, maximum: 3000, interval: 10 },
                    { name: 'Critical Chance', kind: 'percentage', minimum: 0, maximum: 100, interval: 1 },
                    { name: 'Condition Duration', kind: 'percentage', minimum: 0, maximum: 100, interval: 1 },
                    { name: 'Boon Duration', kind: 'percentage', minimum: 0, maximum: 100, interval: 1 }
])

puts 'CREATING ENHANCEMENTS'
Enhancement.create!([
                      { name: 'Power', multiplier: 1, statistic_id: Statistic.find_by_name('Attack Power').id },
                      { name: 'Precision', multiplier: 0.04761904761905, statistic_id: Statistic.find_by_name('Critical Chance').id },
                      { name: 'Toughness', multiplier: 1, statistic_id: Statistic.find_by_name('Armor').id },
                      { name: 'Defense', multiplier: 1, statistic_id: Statistic.find_by_name('Armor').id },
                      { name: 'Vitality', multiplier: 10, statistic_id: Statistic.find_by_name('Hit Points').id },
                      { name: 'Critical Damage', multiplier: 1, statistic_id: Statistic.find_by_name('Critical Damage').id },
                      { name: 'Condition Damage', multiplier: 1, statistic_id: Statistic.find_by_name('Condition Damage').id },
                      { name: 'Healing Power', multiplier: 1, statistic_id: Statistic.find_by_name('Healing Power').id },
                      { name: 'Condition Duraction', multiplier: 1, statistic_id: Statistic.find_by_name('Condition Duration').id },
                      { name: 'Boon Duration', multiplier: 1, statistic_id: Statistic.find_by_name('Boon Duration').id }
])

puts 'CREATING SLOTS'
Slot.create!([
               { name: 'Head' },
               { name: 'Shoulders' },
               { name: 'Chest' },
               { name: 'Arms' },
               { name: 'Legs' },
               { name: 'Feet' }
])

puts 'CREATING WEIGHTS'
Weight.create!([
  { name: 'Light' },
  { name: 'Medium' },
  { name: 'Heavy' }
  ])

puts 'DONE'
