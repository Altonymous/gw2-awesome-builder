require 'rake'
namespace :machine do
  desc "Randomize machine status change for all machines"
  task :randomize_status => [:environment] do |t, args|
    if Rails.env == 'production'
      puts "Task not allowed in Production"
      exit
    end

    status = [
      Enumerators::machine_status[:powered_off],
      Enumerators::machine_status[:powering_off],
      Enumerators::machine_status[:powered_on],
      Enumerators::machine_status[:powering_on],
      Enumerators::machine_status[:deleting],
      Enumerators::machine_status[:deleted],
      Enumerators::machine_status[:reconfiguring],
      Enumerators::machine_status[:restarting],
      Enumerators::machine_status[:restart],
      Enumerators::machine_status[:deploying]
    ]
    machines = Machine.all
    machines.each do |machine|
      index = rand(10)
      machine.power_state = status[index]
      machine.save!
    end
  end

  desc "update a machine status"
  task :update_status, [:name] => [:environment] do |t, args|
    if Rails.env == 'production'
      puts "Y NO RUN IN Production!"
      exit
    end

    parts = args[:name].split(":")

    Machine.find_all_by_Description2(parts[0]).each do |machine|
      if (machine.present?)
        machine.Status = parts[1]
        puts "Updating status for Machine \"#{parts[0]}\" to #{parts[1]}"
        machine.save!
      else
        puts "Unable to find Machine by name #{parts[0]}"
      end
    end
  end
end
