require 'rake'

namespace :outfitter do
  namespace :outfit do
    desc "Clear all armor from the database"
    task :delete_outfits => [:environment] do |t, args|
      Generator::Wrangler.new.destroy_all
    end

    desc "Collect all the gear from external sources"
    task :collect_gear, [:delete_gear] => [:environment] do |t, args|
      delete_gear = args[:delete_gear].blank? ? true : args[:delete_gear]

      Generator::Spidy.new.get_all_items(0)
    end

    desc "Generate all possible outfits from known gear."
    task :generate, [:delete_outfits] => [:environment] do |t, args|
      delete_outfits = args[:delete_outfits].blank? ? true : args[:delete_outfits]

      Generator::Wrangler.new.start(delete_outfits)
    end
  end
end
