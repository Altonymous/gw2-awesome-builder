class Enhancement < ActiveRecord::Base
  attr_accessible :name, :multiplier, :statistic_id

  belongs_to :statistic

  has_many :armors_enhancements
  has_many :armors, through: :armors_enhancements

  validates :name,
    presence:true,
    uniqueness: true,
    length: { maximum: 24 }
  validates :multiplier,
    presence: true,
    numericality: { greater_than: 0 }
  validates :statistic,
    presence: true
end
