class Statistic < ActiveRecord::Base
  resourcify
  attr_accessible :name

  has_many :enhancements

  validates :name,
    presence: true,
    uniqueness: true,
    length: { maximum: 36 }
end
