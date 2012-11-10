class CreateTrinkets < ActiveRecord::Migration
  def change
    create_table :trinkets do |t|
      t.string :name, limit: 48
      t.integer :level

      t.integer :armor
      t.integer :hit_points
      t.integer :attack_power
      t.integer :critical_damage
      t.integer :critical_chance
      t.integer :condition_damage
      t.integer :condition_duration
      t.integer :healing_power
      t.integer :boon_duration

      t.belongs_to :slot

      t.timestamps
    end

    add_index :trinkets, :armor
    add_index :trinkets, :hit_points
    add_index :trinkets, :attack_power
    add_index :trinkets, :critical_damage
    add_index :trinkets, :critical_chance
    add_index :trinkets, :condition_damage
    add_index :trinkets, :condition_duration
    add_index :trinkets, :healing_power
    add_index :trinkets, :boon_duration

    add_index :trinkets, :slot_id
  end
end
