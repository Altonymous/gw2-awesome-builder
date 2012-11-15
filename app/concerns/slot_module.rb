module SlotModule
  SLOT = {
    helm: 1,
    shoulders: 2,
    coat: 3,
    gloves: 4,
    legs: 5,
    boots: 6
  }

  def self.slots
    SLOT.keys
  end

  def self.find_by_slot_id(slot_id)
    SLOT.key(slot_id)
  end
end
