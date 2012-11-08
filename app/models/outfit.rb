class Outfit < ActiveRecord::Base
  attr_accessible :arms_id, :chest_id, :feet_id, :head_id, :legs_id, :shoulders_id

  belongs_to :arms, class_name: :Armor
  belongs_to :chest, class_name: :Armor
  belongs_to :feet, class_name: :Armor
  belongs_to :head, class_name: :Armor
  belongs_to :legs, class_name: :Armor
  belongs_to :shoulders, class_name: :Armor

  include StatisticModule

  def pieces
    %w(arms chest feet head legs shoulders)
  end
end
