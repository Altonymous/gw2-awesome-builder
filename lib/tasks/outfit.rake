require 'rake'

namespace :outfitter do
  desc "Collect gear from external sources & generate all possible outfits."
  task :seed => [:environment] do |t, args|
    Generator::Wrangler.new.seed
  end

  desc "Create random fake outfits and gear"
  task :randomize => [:environment] do |t, args|
    Generator::Wrangler.new.randomize
  end

  desc "Generate all possible outfits, suits, & jewelries from known gear."
  task :generate_all => [:environment] do |t, args|
    Generator::Wrangler.new.create_outfits
  end

  desc "Generate all possible outfits from known suits & jewelries."
  task :generate_outfits => [:environment] do |t, args|
    Generator::Wrangler.new.generate_outfits
  end

  desc "Collect all the gear from external sources"
  task :scrape_gear => [:environment] do |t, args|
    Generator::Wrangler.new.scrape_gear
  end

  desc "Randomize all the gear"
  task :randomize_gear => [:environment] do |t, args|
    Generator::Wrangler.new.randomize_gear
  end

  # desc "Clear all outfits from the database"
  # task :delete_all => [:environment] do |t, args|
  #   Generator::Wrangler.new.delete_all
  # end

  # desc "Clear all outfits from the database"
  # task :delete_outfits => [:environment] do |t, args|
  #   Generator::Wrangler.new.delete_outfits
  # end

  # desc "Clear all gear from the database"
  # task :delete_gear => [:environment] do |t, args|
  #   Generator::Wrangler.new.delete_gear
  # end
end
