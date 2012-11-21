module Generator
  class Wrangler
    def initialize
    end

    def seed
      scrape_gear
      create_outfits
    end

    def randomize
      randomize_gear
      create_outfits
    end

    def create_outfits
      delete_outfits
      puts "Creating outfits..."
      start = Time.now

      generate_jewelries
      generate_suits
      generate_outfits

      puts "Took #{(Time.now - start).round(3)} seconds to create all outfits.\n\n"
    end

    def scrape_gear
      delete_gears
      Generator::Spidy.new.get_all_items
    end

    def randomize_gear
      delete_gears

      pieces = SlotModule::SLOT.values.select { |slot| slot[:slot_type] == 'Armor' }.length * 3 * 3
      pieces = pieces + SlotModule::SLOT.values.select { |slot| slot[:slot_type] == 'Trinket' }.length * 3

      i = 1
      SlotModule::SLOT.values.each do |slot|
        (1..3).each do |instance|
          case slot[:slot_type]
          when 'Armor'
            WeightModule::WEIGHT.values.each do |weight|
              generate_armor("#{weight[:name]} #{slot[:name]} Piece ##{instance}", slot[:id], weight[:id])

              putc '.'
              puts " #{i}/#{pieces}" if (i % 100).eql?(0) || i == pieces.to_i
              i = i.next
            end
          when 'Trinket'
            generate_trinket("#{slot[:name]} Piece ##{instance}", slot[:id])

            putc '.'
            puts " #{i}/#{pieces}" if (i % 100).eql?(0) || i == pieces.to_i
            i = i.next
          end
        end
      end
    end

    # private
    def temp
      outfits = collect_outfits
      create_outfits_sets(outfits)
    end

    def generate_outfits
      puts "  Generating outfits..."
      start = Time.now

      outfits = collect_outfits
      create_outfits_sets(outfits)

      puts "  Took #{(Time.now - start).round(3)} seconds to generate outfits.\n\n"
    end

    # BEGIN OUTFIT CREATION
    def generate_suits
      puts "  Generating suits..."
      start = Time.now

      generate_suits_by_weight

      puts "  Took #{(Time.now - start).round(3)} seconds to generate suits.\n\n"
    end

    def generate_jewelries
      puts "  Generating jewelries..."
      start = Time.now

      # Collecting the gear
      jewelry = collect_trinkets

      # Generating jewelries from gear
      create_jewelries_sets(jewelry)

      # Completing jewelry set generation
      puts "  Took #{(Time.now - start).round(3)} seconds to generate jewelry sets.\n\n"
    end

    # Delete
    def delete_outfits
      print "Deleting Outfits... "
      $stdout.flush
      Outfit.delete_all
      puts "Done\n\n"

      delete_suits
      delete_jewelries
    end

    def delete_gears
      delete_armors
      delete_trinkets
    end

    def delete_suits
      print "Deleting Suits... "
      $stdout.flush
      ArmorsSuit.delete_all
      Suit.delete_all
      puts "Done\n\n"
    end

    def delete_jewelries
      print "Deleting Jewelries... "
      $stdout.flush
      JewelriesTrinket.delete_all
      Jewelry.delete_all
      puts "Done\n\n"
    end

    def delete_armors
      print "Deleting Armors... "
      $stdout.flush
      GearEnhancement.armors.delete_all
      Armor.delete_all
      puts "Done\n\n"
    end

    def delete_trinkets
      print "Deleting Trinkets... "
      $stdout.flush
      GearEnhancement.trinkets.delete_all
      Trinket.delete_all
      puts "Done\n\n"
    end

    def generate_suits_by_weight
      WeightModule::weights.each do |weight|
        puts "    Generating #{weight.to_s.camelize} armor sets...\n\n"
        start = Time.now

        # Collecting the gear
        armor = collect_armor(weight)

        # Generating suits from gear
        create_suits_sets(armor)

        # Completing armor set generation
        puts "    Took #{(Time.now - start).round(3)} seconds to generate #{weight.to_s.camelize} armor sets.\n\n"
      end
    end

    def collect_outfits()
      puts "Collecting outfit pieces..."
      start = Time.now

      outfit_possibilities = {
        jewelry: Jewelry.includes(:trinkets).all,
        suit: Suit.includes(:armors).all
      }

      # puts "#{outfit_possibilities.values.inject(:*)} combinations found."
      puts "Took #{(Time.now - start).round(4)} seconds to collect.\n\n"

      # Show the possible combinations
      # outfit_possibilities.each do |key, values|
      #   puts "#{key} - #{values.map(&:id)}"
      # end

      outfit_possibilities
    end

    def collect_armor(weight)
      puts "      Collecting #{weight.to_s.camelize} armor pieces..."
      start = Time.now
      armor_possibilities = {}

      SlotModule::slots.each do |slot|
        next if SlotModule::SLOT[slot][:slot_type] != 'Armor'

        approved_armor_pieces = []
        possible_armor_pieces = Armor.send(weight).includes(:gear_enhancements, :enhancements).find_all_by_slot_id(SlotModule::SLOT[slot][:id])

        possible_armor_pieces.each do |possible_armor_piece|
          duplicate = false

          # If some armor already matches the statistics, we don't need to add it to the list of possible pieces
          approved_armor_pieces.each do |approved_armor_piece|
            duplicate = approved_armor_piece.gear_enhancements == possible_armor_piece.gear_enhancements && approved_armor_piece.weight_id == possible_armor_piece.weight_id

            break if duplicate
          end

          approved_armor_pieces << possible_armor_piece unless duplicate
        end

        armor_possibilities[slot] = approved_armor_pieces
      end

      # Show the possible combinations
      armor_possibilities.each do |key, values|
        puts "        #{key} - #{values.map(&:id)}"
      end

      # puts "#{armor_possibilities.values.inject(:*)} combinations found."
      puts "    Took #{(Time.now - start).round(3)} seconds to collect.\n\n"

      armor_possibilities
    end

    def collect_trinkets()
      puts "    Collecting trinkets pieces..."
      start = Time.now
      trinket_possibilities = {}

      SlotModule::slots.each do |slot|
        next if SlotModule::SLOT[slot][:slot_type] != 'Trinket'

        approved_trinket_pieces = []
        possible_trinket_pieces = Trinket.includes(:gear_enhancements, :enhancements).find_all_by_slot_id(SlotModule::SLOT[slot][:id])

        possible_trinket_pieces.each do |possible_trinket_piece|
          duplicate = false

          # If some trinkets already matches the statistics, we don't need to add it to the list of possible pieces
          approved_trinket_pieces.each do |approved_trinket_piece|
            duplicate = approved_trinket_piece.gear_enhancements == possible_trinket_piece.gear_enhancements

            break if duplicate
          end

          approved_trinket_pieces << possible_trinket_piece unless duplicate
        end

        if %w(ring accessory).include?(slot.to_s)
          (1..2).each do |i|
            slot_name = "#{slot}_#{i}".to_sym
            trinket_possibilities[slot_name] = approved_trinket_pieces
          end
        else
          trinket_possibilities[slot] = approved_trinket_pieces
        end
      end

      #  Show the possible combinations
      trinket_possibilities.each do |key, values|
        puts "      #{key} - #{values.map(&:id)}"
      end

      # puts "#{trinket_possibilities.values.inject(:*)} combinations found."
      puts "    Took #{(Time.now - start).round(3)} seconds to collect.\n\n"

      trinket_possibilities
    end

    def create_outfits_sets(gear)
      create_sets(:outfit, gear)
    end

    def create_suits_sets(gear)
      create_sets(:suit, gear)
    end

    def create_jewelries_sets(gear)
      create_sets(:jewelry, gear)
    end

    def create_sets(set_type, gear)
      gear_ids = {}
      gear.each { |record| gear_ids[record[0]] = record[1].map(&:id).map! { |p| { record[0] => p } } }

      digits = gear_ids.keys.map!{ |key| gear_ids[key] }

      i = 1
      tablename = ''
      shifted = digits.shift
      shifted.each do |item|
        puts "    Generating group #{i} of #{shifted.length}..."
        permutations_start = Time.now
        sets = [item].product(*digits)
        puts "      # of generated sets in group number - #{i}: #{sets.length}"
        puts "    Took #{(Time.now - permutations_start).round(3)} seconds to generate.\n\n"

        # Storing the sets
        case set_type
        when :outfit
          store_outfits(sets, gear)
          tablename = 'outfits'
        when :suit
          store_suits(sets, gear)
          tablename = 'suits'
        when :jewelry
          store_jewelries(sets, gear)
          tablename = 'jewelries'
        end

        i = i.next
      end

      duplicate_columns = 'armor, hit_points, critical_damage, critical_chance, condition_damage, condition_duration, healing_power, boon_duration, magic_find'
      remove_duplicates(tablename, duplicate_columns)
    end

    def store_outfits(potential_outfits, gear)
      # Storing the outfits
      puts "    Storing Outfits..."
      start = Time.now
      last_time = start

      total_time = 0
      processed = 0
      potential_outfits.each do |item|
        # Reduce & Flatten Hash
        reduced_item = reduce_item(item, gear)

        Outfit.new do |outfit|
          outfit.weight_id = reduced_item[:suit].weight_id
          outfit.suit = reduced_item[:suit]
          outfit.jewelry = reduced_item[:jewelry]
          outfit.save(validate: false)
        end

        processed = processed.next
        if processed % 2500 == 0 || processed == potential_outfits.length
          total_time = total_time + (Time.now - last_time)
          puts "      Took #{(Time.now - last_time).round(3)} seconds to process 2500 outfits, Took #{total_time.round(3)} to process #{processed} outfits in total."
          last_time = Time.now
        end
      end

      puts "    Took #{(Time.now - start).round(3)} seconds to store.\n\n"
    end

    def store_suits(potential_suits, gear)
      # Storing the suits
      puts "    Storing Suits..."
      start = Time.now
      last_time = Time.now

      total_time = 0
      processed = 0
      potential_suits.each do |item|
        # Reduce & Flatten Hash
        reduced_item = reduce_item(item, gear)

        Suit.new do |suit|
          suit.weight_id = reduced_item.values.first.weight_id
          suit.armors = reduced_item.values
          suit.save(validate: false)
        end

        processed = processed.next
        if processed % 2500 == 0 || processed == potential_suits.length
          total_time = total_time + (Time.now - last_time)
          puts "        Took #{(Time.now - last_time).round(3)} seconds to process 2500 suits, Took #{total_time.round(3)} to process #{processed} suits in total."
          last_time = Time.now
        end
      end

      puts "    Took #{(Time.now - start).round(3)} seconds to process & store.\n\n"
    end

    def store_jewelries(potential_jewelries, gear)
      # Storing jewelries
      puts "    Storing Jewelries..."
      start = Time.now
      last_time = start

      total_time = 0
      processed = 0
      potential_jewelries.each do |item|
        # Reduce & Flatten Hash
        reduced_item = reduce_item(item, gear)

        Jewelry.new do |jewelry|
          jewelry.trinkets = reduced_item.values
          jewelry.save(validate: false)
        end

        processed = processed.next
        if processed % 2500 == 0 || processed == potential_jewelries.length
          total_time = total_time + (Time.now - last_time)
          puts "      Took #{(Time.now - last_time).round(3)} seconds to process 2500 jewelries, Took #{total_time.round(3)} to process #{processed} jewelries in total."
          last_time = Time.now
        end
      end

      puts "    Took #{(Time.now - start).round(3)} seconds to store.\n\n"
    end

    def reduce_item(item, gear)
      reduced_item = item.reduce({}, :update)

      # TODO: Map the reduced_item to the gear to reduce database queries
      reduced_item.each do |key, value|
        piece = gear.values.flatten.find { |item| item.id == value; }
        reduced_item[key] = piece
      end

      reduced_item
    end

    def duplicate?(items, possible_item)
      items.include?(possible_item)
    end

    def remove_duplicates(tablename, duplicate_columns)
      # Removing Duplicate records directly from the database
      puts "    Removing Duplicates..."
      start = Time.now

      ActiveRecord::Base.transaction do
        ActiveRecord::Base.connection.execute ("CREATE TEMPORARY TABLE _DISTINCT_#{tablename} AS (SELECT DISTINCT #{duplicate_columns} FROM #{tablename});")
        ActiveRecord::Base.connection.execute ("TRUNCATE #{tablename};")
        ActiveRecord::Base.connection.execute ("INSERT INTO #{tablename}(#{duplicate_columns}, created_at, updated_at) (SELECT *, '#{Time.now}', '#{Time.now}' FROM _DISTINCT_#{tablename});")
        ActiveRecord::Base.connection.execute ("DROP TABLE _DISTINCT_#{tablename};")
      end

      puts "    Took #{(Time.now - start).round(3)} seconds to remove duplicates.\n\n"
    end
    # END OUTFIT GENERATION

    #  BEGIN FAKE GEAR CREATION
    def generate_armor(name, slot_id, weight_id)
      Armor.create! do |armor|
        armor.name = name
        armor.weight_id = weight_id
        armor.slot_id = slot_id
        armor.level = rand(1..80)
        armor.gear_enhancements.build({rating: rand(1..102)}).enhancement = Enhancement.find_by_name(:Defense)

        old_offset = Set.new
        (1..3).each do |j|
          begin
            offset = rand(Enhancement.count)
          end while old_offset.include?(offset)

          armor.gear_enhancements.build({rating: rand(1..102)}).enhancement = Enhancement.first(offset: offset)
          old_offset << offset
        end
      end
    end

    def generate_trinket(name, slot_id)
      Trinket.create! do |trinket|
        trinket.name = name
        trinket.slot_id = slot_id
        trinket.level = rand(1..80)
        trinket.gear_enhancements.build({rating: rand(1..102)}).enhancement = Enhancement.find_by_name(:Defense)

        old_offset = Set.new
        (1..3).each do |j|
          begin
            offset = rand(Enhancement.count)
          end while old_offset.include?(offset)

          trinket.gear_enhancements.build({rating: rand(1..102)}).enhancement = Enhancement.first(offset: offset)
          old_offset << offset
        end
      end
    end
    #  END FAKE GEAR CREATION
  end
end
