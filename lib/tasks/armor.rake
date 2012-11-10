require 'rake'

namespace :outfitter do
  namespace :armor do
    desc "Clear all armor from the database"
    task :clear => [:environment] do |t, args|
      puts 'Deleting Armor...'
      Armor.delete_all
      puts 'Done'
    end

    desc "Create random pieces of armor [:pieces]"
    task :randomize, [:pieces] => [:environment, :clear] do |t, args|
      pieces = args[:pieces] || 100

      puts 'Randomizing Armor Creation...'
      (1..pieces.to_i).each do |i|
        Armor.create! do |armor|
          armor.name = "Armor Piece ##{i}"
          armor.weight = Weight.first(offset: rand(Weight.count))
          armor.slot = Slot.first(offset: rand(Slot.count))
          armor.level = rand(1..80)
          armor.gear_enhancements.build({rating: rand(1..102)}).enhancement = Enhancement.find_by_name(:Defense)

          old_offset = []
          (1..3).each do |j|
            begin
              offset = rand(Enhancement.count)
            end while old_offset.include?(offset)

            armor.gear_enhancements.build({rating: rand(1..102)}).enhancement = Enhancement.first(offset: offset)
            old_offset << offset
          end

          putc '.'
          puts " #{i}/#{pieces}" if (i % 100).eql?(0) || i == pieces.to_i
        end
      end

      puts 'Done'
    end
  end
end
