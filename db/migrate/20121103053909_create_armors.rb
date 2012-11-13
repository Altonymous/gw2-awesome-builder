class CreateArmors < ActiveRecord::Migration
  def change
    create_table :armors do |t|
      t.string :name, limit: 96
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

      t.belongs_to :weight
      t.belongs_to :slot

      t.timestamps
    end

    add_index :armors, :armor
    add_index :armors, :hit_points
    add_index :armors, :attack_power
    add_index :armors, :critical_damage
    add_index :armors, :critical_chance
    add_index :armors, :condition_damage
    add_index :armors, :condition_duration
    add_index :armors, :healing_power
    add_index :armors, :boon_duration

    add_index :armors, :weight_id
    add_index :armors, :slot_id
  end
end
