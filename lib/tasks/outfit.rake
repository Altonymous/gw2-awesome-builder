require 'rake'

namespace :outfitter do
  desc "Collect gear from external sources & generate all possible outfits."
  task :generate => [:environment, :delete_all] do |t, args|
    Generator::Spidy.new.get_all_items
    Generator::Wrangler.new.generate_outfits
  end

  desc "Generate all possible outfits from known gear."
  task :generate_outfits => [:environment, :delete_outfits] do |t, args|
    Generator::Wrangler.new.generate_outfits
  end

  desc "Collect all the gear from external sources"
  task :collect_gear => [:environment, :delete_gear] do |t, args|
    Generator::Spidy.new.get_all_items
  end

  desc "Create random fake outfits and gear"
  task :randomize => [:environment, :delete_all] do |t, args|
    Generator::Wrangler.new.randomize_gear
    Generator::Wrangler.new.generate_outfits

    puts 'Done'
  end

  desc "Clear all outfits from the database"
  task :delete_all => [:environment] do |t, args|
    Generator::Wrangler.new.delete_all
  end

  desc "Clear all outfits from the database"
  task :delete_outfits => [:environment] do |t, args|
    Generator::Wrangler.new.delete_outfits
  end

  desc "Clear all gear from the database"
  task :delete_gear => [:environment] do |t, args|
    Generator::Wrangler.new.delete_gear
  end
end
