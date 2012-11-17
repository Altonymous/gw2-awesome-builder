require 'rake'

namespace :outfitter do
  desc "Collect gear from external sources & generate all possible outfits."
  task :scrape => [:environment, :delete_all] do |t, args|
    Generator::Wrangler.new.scrape
  end

  desc "Create random fake outfits and gear"
  task :randomize => [:environment, :delete_all] do |t, args|
    Generator::Wrangler.new.randomize
  end

  # desc "Generate all possible outfits from known gear."
  # task :generate_outfits => [:environment, :delete_outfits] do |t, args|
  #   Generator::Wrangler.new.generate_outfits
  # end

  # desc "Collect all the gear from external sources"
  # task :collect_gear => [:environment] do |t, args|
  #   Generator::Wrangler.new.get_gear
  # end

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
