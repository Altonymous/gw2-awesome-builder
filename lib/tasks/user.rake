require 'rake'
namespace :user do
  desc "Create user [email, password, [roles]"
  task :create, [:email, :password, :roles] => [:environment] do |t, args|
    if args[:email].blank? || args[:password].blank?
      puts "Must provide email & password."
      abort
    end

    email = args[:email]
    password = args[:password]
    roles = args[:roles].present? ? args[:roles].split(' ') : [:user]

    puts "Creating user with email: #{email}..."
    user = User.create!(email: email, password: password, password_confirmation: password)
    user.confirm!
    puts "User created."

    puts "Add roles to user."
    roles.each { |role| user.add_role(role.to_sym) }
    puts "Roles added."
  end
end
