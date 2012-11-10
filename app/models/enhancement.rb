class Enhancement < ActiveRecord::Base
  attr_accessible :name, :multiplier, :statistic_id

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

  validates_associated :statistic
  validates_presence_of :statistic_id
end
