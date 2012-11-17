class Suit < ActiveRecord::Base
  attr_accessible :armor, :attack_power, :boon_duration, :condition_damage, :condition_duration, :critical_chance, :critical_damage, :healing_power, :hit_points, :magic_find
end
