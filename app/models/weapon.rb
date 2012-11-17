class Weapon < ActiveRecord::Base
  belongs_to :slot
  attr_accessible :armor, :attack_power, :boon_duration, :condition_damage, :condition_duration, :critical_chance, :critical_damage, :gw2db_url, :healing_power, :hit_points, :icon_url, :level, :magic_find, :name
end
