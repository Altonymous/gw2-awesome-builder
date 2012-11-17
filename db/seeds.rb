puts 'STARTING SEED'

puts 'CREATING ROLES'
Role.create!([
               { name: 'administrator' },
               { name: 'user' }
], without_protection: true)

puts 'CREATING STATISTICS'
Statistic.create!(StatisticModule::STATISTIC.values, without_protection: true)

puts 'CREATING ENHANCEMENTS'
Enhancement.create!(EnhancementModule::ENHANCEMENT.values, without_protection: true)

puts 'CREATING SLOTS'
Slot.create!(SlotModule::SLOT.values, without_protection: true)

puts 'CREATING WEIGHTS'
Weight.create!(WeightModule::WEIGHT.values, without_protection: true)

puts 'DONE'
