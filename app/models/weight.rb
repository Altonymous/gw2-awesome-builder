class Weight < ActiveRecord::Base
  attr_accessible :name

  has_many :armors

  validates :name,
    presence:true,
    uniqueness: true,
    length: { maximum: 16 }

  def self.light
    where(name: 'Light').first
  end

  def self.medium
    where(name: 'Medium').first
  end

  def self.heavy
    where(name: 'Heavy').first
  end
end
