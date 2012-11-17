class CreateSlots < ActiveRecord::Migration
  def change
    create_table :slots do |t|
      t.string :name, limit: 32
      t.string :slot_type, :string, limit: 16

      t.timestamps
    end
  end
end
