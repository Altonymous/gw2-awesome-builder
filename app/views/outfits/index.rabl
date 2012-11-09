collection @outfits
attributes :armor,
           :attack_power,
           :hit_points,
           :healing_power,
           :condition_duration,
           :condition_damage,
           :critical_chance,
           :critical_damage,
           :boon_duration

child :head do
  extends "armors/show"
end
