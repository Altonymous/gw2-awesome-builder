class Spidy
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

  def get_items(type)
    results = search_items(type)

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
        gear_enhancements.each { |gear_enhancement| gear_enhancement[gear_type: 'Armor'] }
        Armor.new({ name: name, level: level, weight_id: Weight.find_by_name(weight).id, slot_id: Spidy::armor_sub_type[sub_type_id] })
      end
      puts result
    end

    # name, rarity, restriction_level, img, type_id, sub_type_id
    # defense
    test = {"data_id" => "155",
            "name" => "Carrion Duelist's Coat of the Dolyak",
            "rarity" => "5",
            "restriction_level" => "80",
            "img" => "https://dfach8bufmqqv.cloudfront.net/gw2/img/content/ef82401c.png",
            "type_id" => "0",
            "sub_type_id" => "0",
            "price_last_changed" => "2012-11-12 19:13:28 UTC",
            "max_offer_unit_price" => "30908",
            "min_sale_unit_price" => "125000",
            "offer_availability" => "38",
            "sale_availability" => "3",
            "gw2db_external_id" => "6954",
            "sale_price_change_last_hour" => "0",
            "offer_price_change_last_hour" => "0",
            :stats => {"defense" => {:name => "Defense", :value => "338"},
                       "stat-power" => {:name => "Power", :value => "72"},
                       "stat-condition-damage" => {:name => "Condition Damage", :value => "101"},
                       "stat-vitality" => {:name => "Vitality", :value => "72"},
                       "armor-type-coat" => {:name => "", :value => "Coat"},
                       "armor-weight-medium" => {:name => "", :value => "Medium"}}}
  end

  def search_items(type)
    @extras = "/items/#{type}?sort_name=asc"
    puts "Let's do this! #{@base_url}#{@extras}"

    session = Patron::Session.new
    session.base_url = @base_url
    response = session.get @extras

    response = JSON.parse(response.body)
    results = response['results']
  end

end
