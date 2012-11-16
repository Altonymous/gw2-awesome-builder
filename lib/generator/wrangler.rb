module Generator
  class Wrangler
    def initialize
    end

    def destroy_all
      puts "Deleting Outfits"
      Outfit.destroy_all
      puts "Done\n\n"
    end

    def start(delete_outfits = true)
      destroy_all if delete_outfits

      puts "Generating outfits..."
      start = Time.now

      WeightModule::weights.each do |weight|
        puts "Generating #{weight.to_s.camelize} armor outfits...\n\n"
        weight_start = Time.now

        # Collecting the gear
        gear = collect_gear(weight)

        # Generating outfits from gear
        outfits = generate_outfits(gear)

        # Completing armor set generation
        puts "Took #{(Time.now - weight_start).round(4)} seconds to generate #{weight.to_s.camelize} armor sets.\n\n"
      end
      puts 'Done'
      puts "Took #{(Time.now - start).round(4)} seconds to generate all outfits.\n\n"
    end

    private
    def collect_gear(weight)
      puts "Collecting #{weight.to_s.camelize} armor pieces..."
      collecting_start = Time.now
      gear_possibilities = {}

      SlotModule::slots.each do |slot|
        approved_gear_pieces = []

        case SlotModule::SLOT[slot][:slot_type]
        when 'Armor'
          possible_gear_pieces = Armor.send(weight).includes(:gear_enhancements, :enhancements).find_all_by_slot_id(SlotModule::SLOT[slot][:id])
        when 'Trinket'
          possible_gear_pieces = Trinket.includes(:gear_enhancements, :enhancements).find_all_by_slot_id(SlotModule::SLOT[slot][:id])
        end

        possible_gear_pieces.each do |possible_gear_piece|
          duplicate = false

          # If some armor already matches the statistics, we don't need to add it to the list of possible pieces
          approved_gear_pieces.each do |approved_gear_piece|
            if SlotModule::SLOT[slot][:slot_type] == 'Armor' && approved_gear_piece.weight_id == possible_gear_piece.weight_id
              duplicate = approved_gear_piece.gear_enhancements == possible_gear_piece.gear_enhancements
              if duplicate
                # puts "# Duplicate Found: select * from armors where id in (#{approved_gear_piece.id}, #{possible_gear_piece.id});"
                break
              end
            end
          end

          approved_gear_pieces << possible_gear_piece unless duplicate
        end

        if %w(ring accessory).include?(slot.to_s)
          (1..2).each do |i|
            slot_name = "#{slot}_#{i}".to_sym
            gear_possibilities[slot_name] = approved_gear_pieces
          end
        else
          gear_possibilities[slot] = approved_gear_pieces
        end
      end
      puts "Took #{(Time.now - collecting_start).round(4)} seconds to collect.\n\n"

      gear_possibilities.each do |key, values|
        puts "#{key} - #{values.map(&:id)}"
      end
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
      # queued_outfits = []
      outfits.each do |item|
        reduced_item = item.reduce({}, :update)

        # TODO: Map the reduced_item to the gear to reduce database queries
        reduced_item.each do |key, value|
          piece = gear.values.flatten.find { |item| item.id == value; }
          reduced_item[key] = piece
        end

        Outfit.new do |outfit|
          reduced_item.each do |key, value|
            if %w(ring_1 ring_2 accessory_1 accessory_2 amulet).include?(key.to_s)
              outfit.trinkets << value
            else
              outfit.armors << value
            end
          end
          # outfit.armors = reduced_item.values
          outfit.save(validate: false)
        end
        # Outfit.new(reduced_item).save({validate: false})

        j = j + 1
        if j % 5000 == 0 || j == outfits.length
          # ActiveRecord::Base.transaction do
          #   queued_outfits.each { |outfit| outfit.save({validate: false}) }
          # end
          # queued_outfits = []
          current_count = j < outfits.length ? 5000 : outfits.length % 5000
          puts "#{current_count} items took #{(Time.now - last_time).round(4)} seconds to store"
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
