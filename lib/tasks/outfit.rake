require 'rake'

namespace :outfitter do
  namespace :outfit do
    desc "Clear all armor from the database"
    task :clear => [:environment] do |t, args|
      puts "Deleting Outfits"
      Outfit.delete_all
      puts "Done\n\n"
    end

    desc "Test stat_generation"
    task :test => [:environment] do |t, args|
      # (1..100).each { |i| Outfit.create({helm_id: i, shoulders_id: i, coat_id: i, gloves_id: i, legs_id: i, boots_id: i}) }
      outfits = Outfit.limit(100).order('id asc')
      timing = Benchmark.bm { |b|
        b.report do
          1.times do |i|
            outfits.map {|outfit| outfit.generate_statistics}
          end
        end
      }
      puts timing

      timing = Benchmark.bm { |b|
        b.report do
          1.times do |i|
            outfits.map {|outfit| outfit.gen_stats}
          end
        end
      }
      puts timing
    end

    desc "Generate all possible outfits from known gear."
    task :generate, [:set_limit] => [:environment, :clear] do |t, args|
      set_limit = args[:set_limit]

      puts "Generating outfits..."
      start = Time.now
      total_outfits_generated = 0

      %w(light medium heavy).each do |weight|
        gear_possibilities = {}
        outfits = {}

        puts "Generating #{weight.camelize} armor outfits...\n\n"
        weight_start = Time.now

        # Collecting the gear
        puts "Collecting #{weight.camelize} armor pieces..."
        collecting_start = Time.now
        Slot.all.each do |slot|
          armors = []

          key = "#{slot.name.delete(' ').underscore}_id"
          possible_armors = Armor.send(weight).find_all_by_slot_id(slot.id)
          possible_armors.each do |possible_armor|
            duplicate = false

            # If some armor already matches the statistics, we don't need to add it to the list of possible pieces
            armors.each do |armor|
              if armor.weight_id == possible_armor.weight_id
                duplicate = armor.gear_enhancements == possible_armor.gear_enhancements
                if duplicate
                  puts "# Duplicate Found: select * from armors where id in (#{armor.id}, #{possible_armor.id});"
                  break
                end
              end
            end

            armors << possible_armor unless duplicate
          end

          gear_possibilities[key] = armors.map(&:id)
          puts "  gear_possibilities[#{key}] = #{gear_possibilities[key]}"
        end
        puts "Took #{(Time.now - collecting_start).round(4)} seconds to collect.\n\n"

        # Generating outfits from gear
        # outfits = permutations!(gear_possibilities)
        outfits_generated = generate(gear_possibilities, set_limit)
        total_outfits_generated = total_outfits_generated + outfits_generated

        # Storing the outfits
        # puts "Storing Outfits..."
        # storing_start = Time.now
        # outfits.map! { |item| Outfit.new(item.reduce({}, :update)).save! }
        # puts "Took #{(Time.now - storing_start).round(4)} seconds to store.\n\n"

        # Completing armor set generation
        puts "Took #{(Time.now - weight_start).round(4)} seconds to generate #{weight.camelize} armor sets.\n\n"
      end

      puts 'Done'
      puts "Took #{(Time.now - start).round(4)} seconds to generate #{total_outfits_generated} outfits.\n\n"
    end

    def generate(input, set_limit = nil)
      input.each do |key, possibilities|
        possibilities.map!{|p| {key => p} }
      end

      digits = input.keys.map!{ |key| input[key] }

      i = 1
      total_outfits_generated = 0
      shifted = digits.shift
      shifted.each do |item|
        puts "Generating outfits #{i} of #{shifted.length}..."
        permutations_start = Time.now
        results = [item].product(*digits)
        puts "# of generated outfits in the set number - #{i}: #{results.length}"
        puts "Took #{(Time.now - permutations_start).round(4)} seconds to generate.\n\n"

        # Storing the outfits
        puts "Storing Outfits..."
        last_time = Time.now
        storing_start = Time.now
        j = 1
        outfits = []
        results.each do |item|
          # reduction_time = Time.now
          reduced_item = item.reduce({}, :update)
          # puts "Took #{(Time.now - reduction_time).round(4)} seconds to reduce.\n\n"

          # saved_time = Time.now
          outfit = Outfit.new(reduced_item).save(validate: false)
          total_outfits_generated = total_outfits_generated + 1
          abort("Met the set_limit you were aiming for: #{total_outfits_generated}/#{set_limit}") if set_limit.present? && set_limit.to_i == total_outfits_generated
          # puts "Took #{(Time.now - saved_time).round(4)} seconds to save.\n\n"

          j = j + 1
          if j % 10000 == 0
            # puts "10000 items took #{(Time.now - last_time).round(4)} seconds before import"
            # Outfit.import(outfits, :validate => false)
            # outfits = []
            puts "10000 items took #{(Time.now - last_time).round(4)} seconds after import"
            last_time = Time.now
          end
        end

        puts "Took #{(Time.now - storing_start).round(4)} seconds to store.\n\n"

        i = i + 1
      end

      total_outfits_generated
    end

    def permutations!(input)
      permutations_start = Time.now
      puts "Generating Outfits..."
      input.each do |key, possibilities|
        possibilities.map!{|p| {key => p} }
      end

      digits = input.keys.map!{ |key| input[key] }

      result = digits.shift.product(*digits)
      puts "# of Generated Outfits: #{result.length}"
      puts "Took #{(Time.now - permutations_start).round(4)} seconds to generate.\n\n"

      return result
    end
  end
end
