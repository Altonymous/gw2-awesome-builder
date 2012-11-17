class CreateJewelriesTrinkets < ActiveRecord::Migration
  def change
    create_table :jewelries_trinkets, :id => false do |t|
      t.belongs_to :jewelry
      t.belongs_to :trinket
    end

    add_index :jewelries_trinkets, [:jewelry_id, :trinket_id]
  end
end
