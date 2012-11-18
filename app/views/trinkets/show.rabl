object @trinket
attribute :id
attribute :name

child(:slot) do
  attribute :id
  attribute :name
end

attribute :armor
attribute :attack_power
attribute :hit_points
attribute :healing_power
attribute :condition_damage
attribute :critical_damage
attribute :critical_chance
attribute :condition_duration
attribute :boon_duration

node(:enhancements) do |trinket|
  trinket.gear_enhancements.map do |ge|
    {
      enhancement: ge.enhancement.name,
      rating: ge.rating
    }
  end
end
