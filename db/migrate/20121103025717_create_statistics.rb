class CreateStatistics < ActiveRecord::Migration
  def change
    create_table :statistics do |t|
      t.string :name, limit: 36

      t.timestamps
    end
  end
end
