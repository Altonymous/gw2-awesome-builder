class CreateJewelriesTrinkets < ActiveRecord::Migration
  def change
    create_table :jewelries_trinkets do |t|
      t.belongs_to :jewelry
      t.belongs_to :trinket

      t.timestamps
    end

    add_index :jewelries_trinkets, :jewelry_id
    add_index :jewelries_trinkets, :trinket_id
  end
end
