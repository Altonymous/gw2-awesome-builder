class AddWeightToOutfits < ActiveRecord::Migration
  def up
    change_table :outfits do |t|
      t.integer :weight_id, after: :id
      t.rename :created_at, :old_created_at
      t.rename :updated_at, :old_updated_at
      t.timestamps

      Outfit.all.each do |outfit|
        outfit.created_at = outfit.old_created_at unless outfit.old_updated_at.blank?
        outfit.weight_id = outfit.armors.first.weight_id
        outfit.updated_at = Time.now
        outfit.save
      end

      t.remove :old_created_at
      t.remove :old_updated_at
    end
  end

  def down
    change_table :outfits do |t|
      t.remove :weight_id
    end
  end
end
