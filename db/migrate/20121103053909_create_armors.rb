class CreateArmors < ActiveRecord::Migration
  def change
    create_table :armors do |t|
      t.string :name
      t.integer :kind
      t.integer :slot
      t.integer :defense
      t.integer :level

      t.timestamps
    end
  end
end
