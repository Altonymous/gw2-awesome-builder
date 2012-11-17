class CreateArmorsSuits < ActiveRecord::Migration
  def change
    create_table :armors_suits do |t|
      t.belongs_to :armor
      t.belongs_to :suit

      t.timestamps
    end

    add_index :armors_suits, :armor_id
    add_index :armors_suits, :suit_id
  end
end