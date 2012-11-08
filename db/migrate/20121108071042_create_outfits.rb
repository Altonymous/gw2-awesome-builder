class CreateOutfits < ActiveRecord::Migration
  def change
    create_table :outfits do |t|
      t.belongs_to :arms
      t.belongs_to :chest
      t.belongs_to :feet
      t.belongs_to :head
      t.belongs_to :legs
      t.belongs_to :shoulders

      t.timestamps
    end
    add_index :outfits, :arms_id
    add_index :outfits, :chest_id
    add_index :outfits, :feet_id
    add_index :outfits, :head_id
    add_index :outfits, :legs_id
    add_index :outfits, :shoulders_id
  end
end
