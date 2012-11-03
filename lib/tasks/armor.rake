require 'rake'
namespace :armor do
  desc "Clear all armor from the database"
  task :clear => [:environment] do |t, args|
    Armor.delete_all
  end

  desc "Create random pieces of armor [:pieces]"
  task :randomize, [:pieces] => [:environment, :clear] do |t, args|
    pieces = args[:pieces].to_i || 100

    (1..pieces).each do |i|
      Armor.create! do |armor|
        armor.name = "Armor Piece ##{i}"
        armor.weight = rand(1..3)
        armor.slot = rand(1..6)
        armor.defense = rand(1..250)
        armor.level = rand(1..80)

        old_offset = []
        (1..3).each do |j|
          begin
            offset = rand(Enhancement.count)
          end while old_offset.include?(offset)

          armor.armors_enhancements.build({rating: rand(1..102)}).enhancement = Enhancement.first(offset: offset)
          old_offset << offset
        end
      end
    end
  end
end
