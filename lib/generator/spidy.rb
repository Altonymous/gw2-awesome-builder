module Generator
  class Spidy
    # Enumerators
    @@type = {
      armor: 0,
      weapon: 18,
      trinket: 15
    }
    cattr_reader :type, :instance_reader => false

    @@armor_sub_type = {
      0 => 'Coat',
      1 => 'Legs',
      2 => 'Gloves',
      3 => 'Helm',
      4 => 'Aquatic Helm',
      5 => 'Boots',
      6 => 'Shoulders'
    }
    cattr_reader :armor_sub_type, :instance_reader => false

    @@trinket_sub_type = {
      0 => 'Accessory',
      1 => 'Amulet',
      2 => 'Ring'
    }
    cattr_reader :trinket_sub_type, :instance_reader => false

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

    @@rarity = {
      basic: 1,
      fine: 2,
      masterwork: 3,
      rare: 4,
      exotic: 5,
      legendary: 6
    }
    cattr_reader :rarity, :instance_reader => false

    def initialize
      @base_url = "http://www.gw2spidy.com/api/v0.9/json"
    end

    def destroy_all
      Armor.destroy_all
      Trinket.destroy_all
    end

    def get_all_items(delete_armors = false)
      destroy_all if delete_armors

      get_items(:trinket)
      # get_items(:armor)
    end

    def get_items(type)
      results = collect_items(type)
      # results.select! { |item| item if item['restriction_level'] == "80" && item['rarity'].to_i == 5 }

      results.each do |result|
        # Skip the item if it's not level 80 & Exotic
        next unless result['restriction_level'].to_i == 80 && result['rarity'].to_i == 5 && !result['name'].downcase.include?('pvp')
         # && !result['name'].downcase.include?(' of ')

        name = result['name']
        name = name.split(' of ')[0] if name.include?(' of ')
        level = result['restriction_level'].to_i
        sub_type_id = result['sub_type_id'].to_i
        icon_url = result['img']

        gw2db_item_id = result['gw2db_external_id']
        gw2db_url = "http://www.gw2db.com/items/#{gw2db_item_id}"

        gw2db = Noko.new
        gear_enhancements_array, weight = gw2db.get_gear_enhancements(gw2db_url)

        case type
        when :armor
          armor = Armor.find_or_initialize_by_name_and_level_and_weight_id_and_slot_id({
                                                                                         name: name,
                                                                                         level: level,
                                                                                         weight_id: Weight.find_by_name(weight).id,
                                                                                         slot_id: Slot.find_by_name(Spidy::armor_sub_type[sub_type_id]).id
          })

          gear_enhancements = []
          gear_enhancements_array.each do |gear_enhancement_hash|
            gear_enhancement_hash[:gear_id] = armor.id
            gear_enhancement_hash[:gear_type] = 'Armor'
            gear_enhancement = GearEnhancement.find_or_initialize_by_gear_id_and_enhancement_id(gear_enhancement_hash)
            gear_enhancements << gear_enhancement
          end

          armor.gear_enhancements = gear_enhancements
          armor.gw2db_url = gw2db_url
          armor.icon_url = icon_url
          armor.save if armor.valid?
        when :trinket
          trinket = Trinket.find_or_initialize_by_name_and_level_and_slot_id({
                                                                               name: name,
                                                                               level: level,
                                                                               slot_id: Slot.find_by_name(Spidy::trinket_sub_type[sub_type_id]).id
          })

          gear_enhancements = []
          gear_enhancements_array.each do |gear_enhancement_hash|
            gear_enhancement_hash[:gear_id] = trinket.id
            gear_enhancement_hash[:gear_type] = 'Trinket'
            gear_enhancement = GearEnhancement.find_or_initialize_by_gear_id_and_enhancement_id(gear_enhancement_hash)
            gear_enhancements << gear_enhancement
          end

          trinket.gear_enhancements = gear_enhancements
          trinket.gw2db_url = gw2db_url
          trinket.icon_url = icon_url
          trinket.save if trinket.valid?
        end
      end

      true
    end

    def collect_items(type)
      @extras = "/all-items/#{Spidy::type[type]}"
      puts "Let's do this! #{@base_url}#{@extras}"

      session = Patron::Session.new
      session.timeout = 15
      session.base_url = @base_url
      response = session.get @extras

      response = JSON.parse(response.body)
      results = response['results']
    end

    def search_items(type, page)
      @extras = "/items/#{Spidy::type[type]}/#{page}?sort_name=asc"
      puts "Let's do this! #{@base_url}#{@extras}"

      session = Patron::Session.new
      session.base_url = @base_url
      response = session.get @extras

      response = JSON.parse(response.body)
      results = response['results']
    end
  end
end
