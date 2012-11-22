class ArmorsSuit < ActiveRecord::Base
  belongs_to :armor
  belongs_to :suit
end
