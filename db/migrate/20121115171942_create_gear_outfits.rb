class CreateGearOutfits < ActiveRecord::Migration
  def change
    create_table :gear_outfits do |t|
      t.references :gear, polymorphic: true
      t.belongs_to :outfit

      t.timestamps
    end

    add_index :gear_outfits, :gear_id
    add_index :gear_outfits, :outfit_id
  end
end
