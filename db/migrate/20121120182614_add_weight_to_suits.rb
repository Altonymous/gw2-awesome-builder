class AddWeightToSuits < ActiveRecord::Migration
  def up
    change_table :suits do |t|
      t.integer :weight_id, after: :magic_find
      t.rename :created_at, :old_created_at
      t.rename :updated_at, :old_updated_at
      t.timestamps

      Suit.all.each do |suit|
        suit.created_at = suit.old_created_at unless suit.old_updated_at.blank?
        suit.weight_id = suit.armors.first.weight_id
        suit.updated_at = Time.now
        suit.save
      end

      t.remove :old_created_at
      t.remove :old_updated_at
    end
  end

  def down
    change_table :suits do |t|
      t.remove :weight_id
    end
  end
end
