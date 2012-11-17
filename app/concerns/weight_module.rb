module WeightModule
  WEIGHT = {
    light: { id: 1, name: 'Light' },
    medium: { id: 2, name: 'Medium' },
    heavy: { id: 3, name: 'Heavy' }
  }

  def self.weights
    WEIGHT.keys
  end

  def self.find_by_weight_id(weight_id)
    WEIGHT.find{|key,value| value[:id] == weight_id}.first
  end
end
