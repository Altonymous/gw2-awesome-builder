class CreateTrinkets < ActiveRecord::Migration
  def change
    create_table :trinkets do |t|
      t.string :name, limit: 48
      t.integer :level

      t.belongs_to :slot

      t.timestamps
    end

    add_index :trinkets, :slot_id
  end
end
