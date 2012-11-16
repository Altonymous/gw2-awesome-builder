class AddSlotTypeToSlots < ActiveRecord::Migration
  def change
    add_column :slots, :slot_type, :string, limit: 16
  end
end
