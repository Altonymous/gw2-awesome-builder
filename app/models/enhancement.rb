class Enhancement < ActiveRecord::Base
  attr_accessible :name, :multiplier, :statistic_id

  belongs_to :statistic

  has_many :armor_enhancements
  has_many :armors, through: :armor_enhancements
end
