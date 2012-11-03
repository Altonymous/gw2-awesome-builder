class Armor < ActiveRecord::Base
  attr_accessible :name, :kind, :slot, :defense, :level, :armor_enhancements, :enhancements

  has_many :armor_enhancements
  has_many :enhancements, through: :armor_enhancements
end
