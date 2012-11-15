class AddGuildWars2DatabaseUrlAndIconUrlToTrinkets < ActiveRecord::Migration
  def up
    change_table :trinkets do |t|
      t.string :gw2db_url, :after => :slot_id
      t.string :icon_url, :after => :slot_id
      t.change :name, :string, limit: 96
      t.rename :created_at, :old_created_at
      t.rename :updated_at, :old_updated_at
      t.timestamps

      Trinket.all.each do |trinket|
        trinket.created_at = trinket.old_created_at
        trinket.updated_at = armor.old_updated_at
      end

      t.remove :old_created_at
      t.remove :old_updated_at
    end
  end

  def down
    change_column :trinkets, :name, limit: 48
    remove_column :trinkets, :gw2db_url
    remove_column :trinkets, :icon_url
  end
end
