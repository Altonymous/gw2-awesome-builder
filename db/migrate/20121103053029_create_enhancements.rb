class CreateEnhancements < ActiveRecord::Migration
  def change
    create_table :enhancements do |t|
      t.string :name
      t.float :multiplier
      t.belongs_to :statistic

      t.timestamps
    end

    add_index :enhancements, :statistic_id
  end
end
