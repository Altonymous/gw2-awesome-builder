object @armor
attribute :id
attribute :name
attribute :armor

child(:slot) do
  attribute :id
  attribute :name
end

attribute :attack_power
attribute :hit_points
attribute :healing_power
attribute :condition_damage
attribute :critical_damage
attribute :critical_chance
attribute :condition_duration
attribute :boon_duration

node(:enhancements) do |armor|
  armor.gear_enhancements.map do |ge|
    {
      enhancement: ge.enhancement.name,
      rating: ge.rating
    }
  end
end
