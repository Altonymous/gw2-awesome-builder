class Armor < ActiveRecord::Base
  attr_accessible :name, :weight, :slot, :defense, :level, :armors_enhancements, :enhancements

  has_many :armors_enhancements
  has_many :enhancements, through: :armors_enhancements
end
