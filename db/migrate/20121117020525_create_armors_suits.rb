class CreateArmorsSuits < ActiveRecord::Migration
  def change
    create_table :armors_suits, :id => false do |t|
      t.belongs_to :armor
      t.belongs_to :suit
    end

    add_index :armors_suits, [:armor_id, :suit_id]
  end
end