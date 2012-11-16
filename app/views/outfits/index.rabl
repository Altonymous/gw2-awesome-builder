collection @outfits
object false

node :pagination do
  attributes :total_count => @outfits.total_count,
             :default_per_page => @outfits.default_per_page,
             :current_page => @outfits.current_page
end

child(@outfits) do
  attributes :id,
             :armor,
             :attack_power,
             :hit_points,
             :healing_power,
             :condition_duration,
             :condition_damage,
             :critical_chance,
             :critical_damage,
             :boon_duration
end
