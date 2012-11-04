class Weight < ActiveRecord::Base
  attr_accessible :name

  has_many :armors

  validates :name,
    presence:true,
    uniqueness: true,
    length: { maximum: 16 }
end
