module SlotModule
  SLOT = {
    helm: { id: 1, name: 'Helm', slot_type: 'Armor' },
    shoulders: { id: 2, name: 'Shoulders', slot_type: 'Armor' },
    coat: { id: 3, name: 'Coat', slot_type: 'Armor' },
    gloves: { id: 4, name: 'Gloves', slot_type: 'Armor' },
    legs: { id: 5, name: 'Legs', slot_type: 'Armor' },
    boots: { id: 6, name: 'Boots', slot_type: 'Armor' },
    ring: { id: 7, name: 'Ring', slot_type: 'Trinket' },
    accessory: { id: 8, name: 'Accessory', slot_type: 'Trinket' },
    amulet: { id: 9, name: 'Amulet', slot_type: 'Trinket' }
  }

  def self.slots
    SLOT.keys
  end

  def self.find_by_slot_id(slot_id)
    SLOT.find{|key,value| value[:id] == slot_id}.first
  end
end
