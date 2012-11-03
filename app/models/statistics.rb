class Statistic < ActiveRecord::Base
  attr_accessible :name, :kind, :minimum, :maximum, :interval
end
