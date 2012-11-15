object @outfit
attributes :armor,
           :attack_power,
           :hit_points,
           :healing_power,
           :condition_duration,
           :condition_damage,
           :critical_chance,
           :critical_damage,
           :boon_duration

child(:helm => :helm) do
  extends "armors/show"
end
child(:shoulders => :shoulders) do
  extends "armors/show"
end
child(:coat => :coat) do
  extends "armors/show"
end
child(:gloves => :gloves) do
  extends "armors/show"
end
child(:legs => :legs) do
  extends "armors/show"
end
child(:boots => :boots) do
  extends "armors/show"
end