class CreateJewelries < ActiveRecord::Migration
  def change
    create_table :jewelries do |t|
      t.integer :armor
      t.integer :hit_points
      t.integer :attack_power
      t.integer :critical_damage
      t.integer :critical_chance
      t.integer :condition_damage
      t.integer :condition_duration
      t.integer :healing_power
      t.integer :boon_duration
      t.integer :magic_find

      t.timestamps
    end
  end
end
