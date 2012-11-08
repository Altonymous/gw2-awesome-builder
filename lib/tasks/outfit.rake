require 'rake'

namespace :outfitter do
  namespace :outfit do
    desc "Clear all armor from the database"
    task :clear => [:environment] do |t, args|
      puts 'DELETING OUTFITS'
      Outfit.delete_all
      puts 'DONE'
    end

    desc "Generate all possible outfits from known gear."
    task :generate => [:environment, :clear] do |t, args|

      puts 'GENERATING OUTFIT COMBINATIONS'

      gear_possibilities = {}
      slots = Slot.all
      slots.each do |slot|
        gear_possibilities[slot.name.delete(' ').underscore] = Armor.find_all_by_slot_id(slot.id).map(&:id)
        # puts "gear_possibilities[#{slot.id}] = #{gear_possibilities[slot.id]}"
      end
      slot_names = slots.map { |slot| "#{slot.name.delete(' ').underscore}_id" }

      outfits = []
      permutations = multi_permutations(gear_possibilities)
      permutations.each do |permutation|
        outfits << Hash[slot_names.zip permutation.flatten!]
      end

      outfits.each do |outfit|
        Outfit.create!(outfit)
      end

      puts 'DONE'
    end

    def multi_permutations(collection)
      case collection.length
      when 1
        return collection.shift[1]
      when 0
        raise "You must pass in a multidimensional collection."
      end

      a = collection.shift[1]
      b = multi_permutations(collection)

      return_value = []
      a.each do |a_value|
        b.each do |b_value|
          return_value << [a_value] + [b_value]
        end
      end

      return return_value
    end
  end
end
