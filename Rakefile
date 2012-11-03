#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Gw2AwesomeBuilder::Application.load_tasks

# Protect destructive rake tasks in the production environment.
#
# The risk on staging is high because the default RAILS_ENV is production and unless
# this is set explicitly, it's very easy to corrupt the production database.
# Not to mention that you would rarely - if ever - want to run any of these in your
# production environment anyways.

# This might affect some Capistrano cold deploy tasks which prepare the database, but
# you only need to do that once...
task = ARGV.first
if !task.nil? && ENV['FORCE'] != 'true' && Rails.env.production?
  PROTECT_SOME = %w( db:setup db:schema:load db:reset db:load db:fixtures:load db:data:load db:migrate:reset)
  PROTECT_ALL  = %w( db:seed db:drop )
  if task =~ Regexp.new(PROTECT_SOME.join('|')) || task =~ Regexp.new(PROTECT_ALL.join('.*|') + '.*')
    puts <<-END.gsub(/^[ ]+/, '')
      ****************************************************************************
      * WARNING! You are in the PRODUCTION environment and are running a Rake task
      * that will DESTROY your PRODUCTION database!
      *
      * If you know what you are doing you can run this task with FORCE=true to
      * prevent this message appearing.
      ****************************************************************************

      Are you sure? (Yes|No) [No]
    END
    confirmation = STDIN.gets.chomp.downcase
    puts('Quitting.') || exit unless confirmation == 'yes'
  end
end