module WeightModule
  WEIGHT = {
    light: 1,
    medium: 2,
    heavy: 3
  }

  def self.weights
    WEIGHT.keys
  end

  def self.find_by_weight_id(weight_id)
    WEIGHT.key(weight_id)
  end
end
