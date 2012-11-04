class CreateWeights < ActiveRecord::Migration
  def change
    create_table :weights do |t|
      t.string :name, limit: 16

      t.timestamps
    end
  end
end
