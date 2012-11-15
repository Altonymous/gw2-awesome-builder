module Generator
  class Wrangler
    def initialize
    end

    def delete_all
      puts "Deleting Outfits"
      Outfit.delete_all
      puts "Done\n\n"
    end

    def start(delete_outfits = true)
      delete_all if delete_outfits

      puts "Generating outfits..."
      start = Time.now
      %w(light medium heavy).each do |weight|
        puts "Generating #{weight.camelize} armor outfits...\n\n"
        weight_start = Time.now

        # Collecting the gear
        gear = collect_gear(weight)

        # Generating outfits from gear
        outfits = generate_outfits(gear)

        # Completing armor set generation
        puts "Took #{(Time.now - weight_start).round(4)} seconds to generate #{weight.camelize} armor sets.\n\n"
      end
      puts 'Done'
      puts "Took #{(Time.now - start).round(4)} seconds to generate all outfits.\n\n"
    end

    private
    def collect_gear(weight)
      puts "Collecting #{weight.camelize} armor pieces..."
      collecting_start = Time.now
      gear_possibilities = {}

      Slot.all.each do |slot|
        approved_gear_pieces = []

        slot_name = "#{slot.name.delete(' ').underscore}"
        possible_gear_pieces = Armor.send(weight).includes(:gear_enhancements, :enhancements).find_all_by_slot_id(slot.id)
        possible_gear_pieces.each do |possible_gear_piece|
          duplicate = false

          # If some armor already matches the statistics, we don't need to add it to the list of possible pieces
          approved_gear_pieces.each do |approved_gear_piece|
            if approved_gear_piece.weight_id == possible_gear_piece.weight_id
              duplicate = approved_gear_piece.gear_enhancements == possible_gear_piece.gear_enhancements
              if duplicate
                # puts "# Duplicate Found: select * from armors where id in (#{approved_gear_piece.id}, #{possible_gear_piece.id});"
                break
              end
            end
          end

          approved_gear_pieces << possible_gear_piece unless duplicate
        end

        gear_possibilities[slot_name] = approved_gear_pieces
        # puts "  gear_possibilities[#{slot_name}] = #{approved_gear_pieces.map(&:id)}"
      end
      puts "Took #{(Time.now - collecting_start).round(4)} seconds to collect.\n\n"

      gear_possibilities
    end

    def generate_outfits(gear)
      gear_ids = {}
      gear.each { |record| gear_ids[record[0]] = record[1].map(&:id).map! { |p| { record[0] => p } } }

      digits = gear_ids.keys.map!{ |key| gear_ids[key] }

      i = 1
      shifted = digits.shift
      shifted.each do |item|
        puts "Generating outfits #{i} of #{shifted.length}..."
        permutations_start = Time.now
        outfits = [item].product(*digits)
        puts "# of generated outfits in the set number - #{i}: #{outfits.length}"
        puts "Took #{(Time.now - permutations_start).round(4)} seconds to generate.\n\n"

        # Storing the outfits
        store_outfits(outfits, gear)

        i = i + 1
      end
    end

    def store_outfits(outfits, gear)
      # Storing the outfits
      puts "Storing Outfits..."
      last_time = Time.now
      storing_start = Time.now

      j = 1
      outfits.each do |item|
        reduced_item = item.reduce({}, :update)

        # TODO: Map the reduced_item to the gear to reduce database queries
        reduced_item.each do |key, value|
          piece = gear.values.flatten.find { |item| item.id == value; }
          reduced_item[key] = piece
        end

        Outfit.new(reduced_item).save({validate: false})
        # Old way...
        # outfit = Outfit.new(reduced_item).save(validate: false)

        j = j + 1
        if j % 10000 == 0
          puts "10000 items took #{(Time.now - last_time).round(4)} seconds after import"
          last_time = Time.now
        end
      end

      puts "Took #{(Time.now - storing_start).round(4)} seconds to store.\n\n"
    end

    def old_janx!(input)
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
