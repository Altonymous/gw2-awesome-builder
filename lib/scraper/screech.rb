module Scraper
  class Screech
    # Enumerators
    @@type = {
      armor: 0,
      bag: 2,
      consumable: 3,
      weapon: 18,
    }
    cattr_reader :type, :instance_reader => false

    @@armor_sub_type = {
      coat: 0,
      legs: 1,
      gloves: 2,
      helm: 3,
      aquatic_helm: 4,
      boots: 5,
      shoulders: 6
    }
    cattr_reader :armor_sub_type, :instance_reader => false

    @@weapon_sub_type = {
      axe: 4,
      dagger: 5,
      focus: 13,
      greatsword: 6,
      hammer: 1,
      harpoon_gun: 20,
      longbow: 2,
      mace: 7,
      pistol: 8,
      rifle: 10,
      scepter: 11,
      shield: 16,
      short_bow: 3,
      spear: 19,
      staff: 12,
      sword: 0,
      torch: 14,
      toy: 22,
      trident: 21,
      warhorn: 15
    }
    cattr_reader :weapon_sub_type, :instance_reader => false

    @@sub_type_mapping = {
      armor: @@armor_sub_type
    }
    cattr_reader :sub_type_mapping, :instance_reader => false

    @@rarity = {
      basic: 1,
      fine: 2,
      masterwork: 3,
      rare: 4,
      exotic: 5,
      legendary: 6
    }
    cattr_reader :rarity, :instance_reader => false

    def initialize(email, password)
      @connection = Scraper::ConnectionManager.new
      @connection.login(email, password)
    end

    def zoom(name_like, type, sub_type, rarity, min_level, max_level, page)
      offset = page.blank? || page == 1 ? 0 : ((page - 1) * 10) + 1
      type_value = Screech::type[type]

      # Not sure if this will work
      sub_type_mapping = Screech::sub_type_mapping[type]
      sub_type_value = sub_type_mapping[sub_type]
      rarity_value = Screech::rarity[rarity]

      params = {
        text: name_like,
        type: type_value,
        subtype: sub_type_value,
        rarity: rarity_value,
        levelmin: min_level,
        levelmax: max_level,
        offset: offset
      }

      @connection.get('search', params)
    end

    def details(id)
      @connection.get('listings', { id: id })
    end
  end
end
