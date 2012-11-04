class CreateGearEnhancements < ActiveRecord::Migration
  def change
    create_table :gear_enhancements do |t|
      t.references :gear, polymorphic: true
      t.belongs_to :enhancement
      t.integer :rating

      t.timestamps
    end

    add_index :gear_enhancements, :gear_id
    add_index :gear_enhancements, :enhancement_id
  end
end
