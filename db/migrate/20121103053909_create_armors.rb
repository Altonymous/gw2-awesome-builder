class CreateArmors < ActiveRecord::Migration
  def change
    create_table :armors do |t|
      t.string :name, limit: 48
      t.integer :level

      t.belongs_to :weight
      t.belongs_to :slot

      t.timestamps
    end

    add_index :armors, :weight_id
    add_index :armors, :slot_id
  end
end
