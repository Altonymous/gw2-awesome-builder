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
    Armor.delete_all
    (1...100000).each do |i|
      break if get_items(0, i)
      sleep(rand(3..20).seconds)
    end
  end

  def get_items(type, page)
    results = search_items(type, page)

    results.select! { |item| item if item['restriction_level'] == "80" }

    # Not sure if the filter is working or not, we're getting weird data right now
    # results.select! { |item| item if item['rarity'] == 5 }
    results.map do |result|
      # I do this to filter out bogus items
      item_id = result['gw2db_external_id']
      name = result['name']
      level = result['restriction_level'].to_i
      sub_type_id = result['sub_type_id'].to_i
      scrubbed_name = name.gsub(/'/, '').parameterize
      scrubbed_name = "-#{scrubbed_name}" unless scrubbed_name.length < 1
      url = "http://www.gw2db.com/items/#{item_id}#{scrubbed_name}"

      gw2db = Noko.new
      gear_enhancements, weight = gw2db.get_gear_enhancements(url)

      case type
      when 0 # Armor
        gear_enhancements.each { |gear_enhancement| gear_enhancement.gear_type = 'Armor' }
        Armor.create!({
                    name: name,
                    level: level,
                    weight_id: Weight.find_by_name(weight).id,
                    slot_id: Slot.find_by_name(Spidy::armor_sub_type[sub_type_id]).id
        }) do |armor|
          armor.gear_enhancements = gear_enhancements
        end
      end
    end

    results.blank?
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
