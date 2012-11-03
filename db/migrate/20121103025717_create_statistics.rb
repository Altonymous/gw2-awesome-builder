class CreateStatistics < ActiveRecord::Migration
  def change
    create_table :statistics do |t|
      t.string :name, limit: 36
      t.string :kind, limit: 12
      t.integer :minimum
      t.integer :maximum
      t.integer :interval

      t.timestamps
    end
  end
end
