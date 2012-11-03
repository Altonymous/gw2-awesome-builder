class Enhancement < ActiveRecord::Base
  attr_accessible :name, :multiplier, :statistic_id

  belongs_to :statistic

  has_many :armors_enhancements
  has_many :armors, through: :armors_enhancements
end
