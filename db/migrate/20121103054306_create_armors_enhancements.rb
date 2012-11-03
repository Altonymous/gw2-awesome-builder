class CreateArmorsEnhancements < ActiveRecord::Migration
  def change
    create_table :armors_enhancements do |t|
      t.belongs_to :armor
      t.belongs_to :enhancement
      t.integer :rating

      t.timestamps
    end

    add_index :armors_enhancements, :armor_id
    add_index :armors_enhancements, :enhancement_id
  end
end
