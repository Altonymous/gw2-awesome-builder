class Noko
  require 'nokogiri'
  require 'open-uri'

  def initialize
    @base_url = "http://www.gw2db.com/items/"
    @base_params = "&filter-item-rarity=6&filter-item-minimum-required-level=80&filter-item-maximum-required-level=80"

    @weight = {'light' => 1, 'medium' => '3','heavy' => 2}
  end

  def get_items(category, type, weight)
    doc = Nokogiri::HTML(open("http://www.gw2db.com/items/#{category}/#{type}/?filter-item-armor-weight-type=#{@weight[weight]}#{@base_params}"))
    # puts "http://www.gw2db.com/items/#{category}/#{type}/?filter-item-armor-weight-type=#{@weight[weight]}#{@base_params}"

    items = Hash.new

    doc.css('.gwitem').map do |link|
      url = "http://www.gw2db.com#{link['href']}"
      page = Nokogiri::HTML(open url)


      item = Hash.new

      # Get Item Name
      item['name'] = page.css('header h2.caption').first.text
      item = item.merge(get_stat(page.css('.db-defense')))

      puts

      page.css('.db-stat').each do |stat|
        stats = get_stat(stat)
        item = item.merge(stats)
      end

      puts "# Name: #{item["name"]} -----"
      puts "  Defense: #{item["defense"]}"
      puts "  Power: #{item["power"]}"
      puts "  Vitality: #{item["vitality"]}"
      puts "  Precision: #{item["precision"]}"
      puts "  Condition Damage: #{item["condition"]}"
      puts "  Toughness: #{item["toughness"]}"
      puts "  Critical Damage: #{item["critical_damage"]}"
      puts "  Critical Chance: #{item["critical_chance"]}"
      puts "  Healing: #{item["healing"]}"
      puts "End -----"

    end

    # items.each do |item|
    #   item
    #   #
    # end
  end

  def get_stat(stat)
    stat_name = stat.text.match(/\w+[a-zA-Z]/).to_s
    stat_name = stat_name.parameterize.underscore
    stat_value = stat.text.match(/\w+[0-9]/).to_s

    {stat_name => stat_value}
  end

  def format_name
    self.name.gsub!(/( )/, '_').downcase!
  end
end




# "http://www.gw2db.com/items/armor/coats?filter-filter-item-type=3&filter-item-rarity=6&filter-item-armor-weight-type=2&filter-item-armor-type=3&filter-item-minimum-required-level=80&filter-item-maximum-required-level=80"
