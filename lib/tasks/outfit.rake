require 'rake'

namespace :outfitter do
  namespace :outfit do
    desc "Clear all armor from the database"
    task :clear => [:environment] do |t, args|
      puts "Deleting Outfits"
      Outfit.delete_all
      puts "Done\n\n"
    end

    desc "Generate all possible outfits from known gear."
    task :generate => [:environment, :clear] do |t, args|
      puts "Collecting Gear..."
      start = sub_start = Time.now
      gear_possibilities = {}
      Slot.all.each do |slot|
        armors = []

        key = "#{slot.name.delete(' ').underscore}_id"
        possible_armors = Armor.find_all_by_slot_id(slot.id)
        possible_armors.each do |possible_armor|
          duplicate = false

          # If some armor already matches the statistics, we don't need to add it to the list of possible pieces
          armors.each do |armor|
            if armor.weight_id == possible_armor.weight_id
              duplicate = armor.gear_enhancements == possible_armor.gear_enhancements
              if duplicate
                puts "# Duplicate Found: select * from armor where id in (#{armor.id}, #{possible_armorid})"
                break
              end
            end
          end

          armors << possible_armor unless duplicate
        end

        gear_possibilities[key] = armors.map(&:id)
        puts "  gear_possibilities[#{key}] = #{gear_possibilities[key]}"
      end
      puts "Gear collected."
      puts "Took #{(Time.now - sub_start).round(4)} seconds to collect.\n\n"

      outfits = permutations!(gear_possibilities)

      puts "Scrubbing Outfits..."
      sub_start = Time.now
      outfits.map! { |item| Outfit.new(item.reduce({}, :update)) }
      puts "Outfits scrubbed."
      puts "Took #{(Time.now - sub_start).round(4)} seconds to scrub.\n\n"

      puts "Storing Outfits..."
      Outfit.import(outfits) unless outfits.blank?
      puts "Outfits stored."
      puts "Took #{(Time.now - sub_start).round(4)} seconds to store.\n\n"

      puts 'Done'
      puts "Took #{(Time.now - start).round(4)} seconds to generate #{outfits.length} outfits.\n\n"
    end

    def permutations!(input)
      sub_start = Time.now
      puts "Generating Outfits..."
      input.each do |key, possibilities|
        possibilities.map!{|p| {key => p} }
      end

      digits = input.keys.map!{|key| input[key] }

      result = digits.shift.product(*digits)
      puts "# of Generated Outfits: #{result.length}"
      puts "Took #{(Time.now - sub_start).round(4)} seconds to generate.\n\n"

      return result
    end
  end
end
