class Slot < ActiveRecord::Base
  attr_accessible :armors, :name

  has_many :armors
end
