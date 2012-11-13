class Spidy
  # Enumerators
  @@type = {
    0 => 'Armor',
    18 => 'Weapon'
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

  def get_all_items()
    # Armor.delete_all
    get_items(0)
    # end
  end

  def get_items(type)
    results = collect_items(type)

    # results.select! { |item| item if item['restriction_level'] == "80" && item['rarity'].to_i == 5 }

    results.each do |result|
      # Skip the item if it's not level 80 & Exotic
      next unless result['restriction_level'] == "80" && result['rarity'].to_i == 5

      name = result['name']
      level = result['restriction_level'].to_i
      sub_type_id = result['sub_type_id'].to_i
      icon_url = result['img']

      gw2db_item_id = result['gw2db_external_id']
      gw2db_url = "http://www.gw2db.com/items/#{gw2db_item_id}"

      gw2db = Noko.new
      gear_enhancements, weight = gw2db.get_gear_enhancements(gw2db_url)

      case type
      when 0 # Armor
        gear_enhancements.each { |gear_enhancement| gear_enhancement.gear_type = 'Armor' }
        armor = Armor.find_or_initialize_by_name_and_level_and_weight_id_and_slot_id({
                                                                                       name: name,
                                                                                       level: level,
                                                                                       weight_id: Weight.find_by_name(weight).id,
                                                                                       slot_id: Slot.find_by_name(Spidy::armor_sub_type[sub_type_id]).id
        })
        puts "#{gw2db_url}"
        puts "#{icon_url}"

        armor.gear_enhancements = gear_enhancements
        armor.gw2db_url = gw2db_url
        armor.icon_url = icon_url
        armor.save!
      end
    end

    true
  end

  def collect_items(type)
    @extras = "/all-items/#{type}"
    puts "Let's do this! #{@base_url}#{@extras}"

    session = Patron::Session.new
    session.base_url = @base_url
    response = session.get @extras

    response = JSON.parse(response.body)
    results = response['results']
  end

  def search_items(type, page)
    @extras = "/items/#{type}/#{page}?sort_name=asc"
    puts "Let's do this! #{@base_url}#{@extras}"

    session = Patron::Session.new
    session.base_url = @base_url
    response = session.get @extras

    response = JSON.parse(response.body)
    results = response['results']
  end
end
