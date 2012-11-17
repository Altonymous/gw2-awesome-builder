class CreateOutfits < ActiveRecord::Migration
  def change
    create_table :outfits do |t|
      t.belongs_to :jewelry
      t.belongs_to :suit

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

    add_index :outfits, :jewelry_id
    add_index :outfits, :suit_id
  end
end
