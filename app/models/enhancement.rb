class Enhancement < ActiveRecord::Base
  resourcify
  attr_accessible :name, :multiplier, :statistic_id

  # Associations
  belongs_to :statistic
  has_many :gear_enhancements

  # Polymorphic Associations
  has_many :armors, through: :gear_enhancements, source: :gear, source_type: 'Armor'
  has_many :trinkets, through: :gear_enhancements, source: :gear, source_type: 'Trinket'

  # Validations
  validates :name,
    presence:true,
    uniqueness: true,
    length: { maximum: 24 }
  validates :multiplier,
    presence: true,
    numericality: { greater_than: 0 }
  validates :statistic_id,
    presence: true
end
