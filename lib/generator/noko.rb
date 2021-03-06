module Generator
  class Noko
    require 'nokogiri'
    require 'open-uri'

    def initialize
      @base_url = "http://www.gw2db.com/items/"
      @base_params = "&filter-item-rarity=6&filter-item-minimum-required-level=80&filter-item-maximum-required-level=80"

      @weight = {'light' => 1, 'medium' => '3','heavy' => 2}
    end

    def search_items(category, type, weight)
      doc = Nokogiri::HTML(open("http://www.gw2db.com/items/#{category}/#{type}/?filter-item-armor-weight-type=#{@weight[weight]}#{@base_params}"))

      items = Hash.new

      doc.css('.gwitem').map do |link|
        item = get_item("http://www.gw2db.com#{link['href']}")
        items = item.merge(item)

      end
    end

    def get_item(url)
      page = Nokogiri::HTML(open url)

      item = Hash.new
      item[:stats] = Hash.new
      item_html = page.css('.db-summary')
      item[:name] = item_html.css('.db-title').text.strip

      page.css('.db-summary dd').each do |stat|
        stats = get_stat(stat)
        item[:stats] = item[:stats].merge(stats)
      end

      puts "# #{item[:name]} -----"
      gear_enhancements = []
      item[:stats].map do |stat|
        stat_name ||= "#{stat[1][:name]}: "
        stat_value = stat[1][:value]
        puts "  #{stat_name}#{stat_value}".gsub(/\s:\s/, ' ')
      end
      puts "# ---------------------\n\n"

      return item
    end

    def get_gear_enhancements(name, url)
      item = get_item(url)

      weight = ''
      gear_enhancements = []
      item[:stats].map do |stat|
        stat_id = stat[0]
        stat_name = stat[1][:name]
        stat_value = stat[1][:value]

        weight = stat_value if stat_id.include?('armor-weight')
        enhancement = Enhancement.find_by_name(stat_name)
        gear_enhancements << { enhancement_id: enhancement.id, rating: stat_value.to_i } if enhancement.present?
      end

      return gear_enhancements, weight
    end

    def get_stat(stat)
      stat_name = stat.text.gsub(/[^a-zA-Z\s]/,'').squeeze(' ').strip
      stat_name = stat_name.downcase.split(" ").uniq.join(" ").titleize
      stat_class = stat.attribute_nodes[0].to_s.underscore.gsub('_', '-').gsub(/^(db-)/,'')
      stat_id = stat_name.gsub(/'/, '').parameterize
      stat_id = "#{stat_class}-#{stat_id}" unless "#{stat_id}" == stat_class

      stat_value = stat.text.gsub(/[^0-9]/, '').to_s

      if !stat_name.empty? && stat_value.empty?
        stat_value = stat_name.to_s
        stat_name = ""
      end

      if stat_class == "value" ||
          stat_class == "bind-type" ||
          stat_class == "required-level"
        stat_name.clear
        stat_value.clear
        stat_id.clear
      end

      unless stat_value.empty? && stat_name.empty?
        return { "#{stat_id}" => {:name => stat_name, :value => stat_value}}
      else
        return {}
      end
    end


    def format_name
      self.name.gsub!(/( )/, '_').downcase!
    end
  end
end
