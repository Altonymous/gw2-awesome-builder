require 'rake'

namespace :outfitter do
  namespace :outfit do
    desc "Clear all armor from the database"
    task :delete_outfits => [:environment] do |t, args|
      puts "Deleting Outfits"
      Generator::Wrangler.new.delete_all
      puts "Done\n\n"
    end

    desc "Generate all possible outfits from known gear."
    task :generate, [:delete_all, :outfit_limit] => [:environment] do |t, args|
      delete_outfits = args[:delete_outfits].blank? ? true : false
      outfit_limit = args[:outfit_limit].blank? ? nil : args[:outfit_limit].to_i

      Generator::Wrangler.new.start(delete_outfits)
    end
  end
end
