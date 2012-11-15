puts 'STARTING SEED'

puts 'CREATING ROLES'
Role.create!([
               { name: 'administrator' },
               { name: 'user' }
], without_protection: true)

puts 'CREATING STATISTICS'
Statistic.create!([
                    { id: 1, name: 'Armor', kind: 'numeric', minimum: 0, maximum: 3000, interval: 10 },
                    { id: 2, name: 'Attack Power', kind: 'numeric', minimum: 0, maximum: 3000, interval: 10 },
                    { id: 3, name: 'Hit Points', kind: 'numeric', minimum: 0, maximum: 60000, interval: 100 },
                    { id: 4, name: 'Healing Power', kind: 'numeric', minimum: 0, maximum: 3000, interval: 10 },
                    { id: 5, name: 'Condition Damage', kind: 'numeric', minimum: 0, maximum: 3000, interval: 10 },
                    { id: 6, name: 'Critical Damage', kind: 'numeric', minimum: 0, maximum: 3000, interval: 10 },
                    { id: 7, name: 'Critical Chance', kind: 'percentage', minimum: 0, maximum: 100, interval: 1 },
                    { id: 8, name: 'Condition Duration', kind: 'percentage', minimum: 0, maximum: 100, interval: 1 },
                    { id: 9, name: 'Boon Duration', kind: 'percentage', minimum: 0, maximum: 100, interval: 1 }
])

puts 'CREATING ENHANCEMENTS'
Enhancement.create!([
                      { id: 1, name: 'Power', multiplier: 1, statistic_id: Statistic.find_by_name('Attack Power').id },
                      { id: 2, name: 'Precision', multiplier: 0.04761904761905, statistic_id: Statistic.find_by_name('Critical Chance').id },
                      { id: 3, name: 'Toughness', multiplier: 1, statistic_id: Statistic.find_by_name('Armor').id },
                      { id: 4, name: 'Defense', multiplier: 1, statistic_id: Statistic.find_by_name('Armor').id },
                      { id: 5, name: 'Vitality', multiplier: 10, statistic_id: Statistic.find_by_name('Hit Points').id },
                      { id: 6, name: 'Critical Damage', multiplier: 1, statistic_id: Statistic.find_by_name('Critical Damage').id },
                      { id: 7, name: 'Condition Damage', multiplier: 1, statistic_id: Statistic.find_by_name('Condition Damage').id },
                      { id: 8, name: 'Healing Power', multiplier: 1, statistic_id: Statistic.find_by_name('Healing Power').id },
                      { id: 9, name: 'Condition Duration', multiplier: 1, statistic_id: Statistic.find_by_name('Condition Duration').id },
                      { id: 10, name: 'Boon Duration', multiplier: 1, statistic_id: Statistic.find_by_name('Boon Duration').id }
])

puts 'CREATING SLOTS'
Slot.create!([
               { id: 1, name: 'Helm' },
               { id: 2, name: 'Shoulders' },
               { id: 3, name: 'Coat' },
               { id: 4, name: 'Gloves' },
               { id: 5, name: 'Legs' },
               { id: 6, name: 'Boots' }
])

puts 'CREATING WEIGHTS'
Weight.create!([
  { id: 1, name: 'Light' },
  { id: 2, name: 'Medium' },
  { id: 3, name: 'Heavy' }
  ])

puts 'DONE'
