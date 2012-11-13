class CreateOutfits < ActiveRecord::Migration
  def change
    create_table :outfits do |t|
      t.integer :armor
      t.integer :hit_points
      t.integer :attack_power
      t.integer :critical_damage
      t.integer :critical_chance
      t.integer :condition_damage
      t.integer :condition_duration
      t.integer :healing_power
      t.integer :boon_duration

      t.belongs_to :gloves
      t.belongs_to :coat
      t.belongs_to :boots
      t.belongs_to :helm
      t.belongs_to :legs
      t.belongs_to :shoulders

      t.timestamps
    end

    add_index :outfits, :armor
    add_index :outfits, :hit_points
    add_index :outfits, :attack_power
    add_index :outfits, :critical_damage
    add_index :outfits, :critical_chance
    add_index :outfits, :condition_damage
    add_index :outfits, :condition_duration
    add_index :outfits, :healing_power
    add_index :outfits, :boon_duration

    add_index :outfits, :gloves_id
    add_index :outfits, :coat_id
    add_index :outfits, :boots_id
    add_index :outfits, :helm_id
    add_index :outfits, :legs_id
    add_index :outfits, :shoulders_id
  end
end
