class DropPiecesFromOutfits < ActiveRecord::Migration
  def up
    remove_index :outfits, :helm_id
    remove_index :outfits, :shoulders_id
    remove_index :outfits, :coat_id
    remove_index :outfits, :gloves_id
    remove_index :outfits, :legs_id
    remove_index :outfits, :boots_id

    change_table :outfits do |t|
      t.remove :helm_id
      t.remove :shoulders_id
      t.remove :coat_id
      t.remove :gloves_id
      t.remove :legs_id
      t.remove :boots_id
    end
  end

  def down
    change_table :outfits do |t|
      t.belongs_to :gloves
      t.belongs_to :coat
      t.belongs_to :boots
      t.belongs_to :helm
      t.belongs_to :legs
      t.belongs_to :shoulders
    end

    add_index :outfits, :gloves_id
    add_index :outfits, :coat_id
    add_index :outfits, :boots_id
    add_index :outfits, :helm_id
    add_index :outfits, :legs_id
    add_index :outfits, :shoulders_id

    # TODO: Maybe write a migration script.  But probably not.
  end
end
