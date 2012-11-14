require 'rake'

namespace :outfitter do
  namespace :database do
    desc "Reset the database.yml"
    task :reset_yaml => [:environment] do |t, args|
      if Rails.env.development? || Rails.env.test?
        File.delete("#{Rails.root}/config/database.yml") if File.exist?("#{Rails.root}/config/database.yml")
        File.symlink("#{Rails.root}/config/database.bkp", "#{Rails.root}/config/database.yml")
      end
    end
  end
end