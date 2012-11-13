class AddGuildWars2DatabaseUrlAndIconUrlToArmors < ActiveRecord::Migration
  def up
    change_table :armors do |t|
      t.string :gw2db_url, :after => :slot_id
      t.string :icon_url, :after => :slot_id
      t.rename :created_at, :old_created_at
      t.rename :updated_at, :old_updated_at
      t.timestamps

      Armor.all.each do |armor|
        armor.created_at = armor.old_created_at
        armor.updated_at = armor.old_updated_at
      end

      t.remove :old_created_at
      t.remove :old_updated_at
    end
  end

  def down
    remove_column :armors, :gw2db_url
    remove_column :armors, :icon_url
  end
end
