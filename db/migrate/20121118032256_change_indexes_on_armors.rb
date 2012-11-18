class ChangeIndexesOnArmors < ActiveRecord::Migration
  def change
    add_index :armors, [:weight_id, :slot_id]
    remove_index :armors, :slot_id
  end
end
