require 'rake'

namespace :outfitter do
  namespace :scraper do
    desc "Clear all armor from the database"
    task :clear => [:environment] do |t, args|
      puts "------  THIS IS CURRENTLY COMMENTED OUT UNTIL IT'S LOADING Armor"
      # puts "Deleting Armors"
      # Armor.delete_all
      # puts "Done\n\n"

      # puts "Deleting Outfits"
      # Outfit.delete_all
      # puts "Done\n\n"
    end

    desc "Gather all that sexy gear."
    task :screech, [:email, :password] => [:environment, :clear] do |t, args|
      email = args[:email]
      password = args[:password]

      response = Scraper.new(email, password).login_patron

      puts response.body
    end
  end
end