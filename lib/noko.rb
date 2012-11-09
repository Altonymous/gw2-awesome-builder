class Noko
  require 'nokogiri'
  require 'open-uri'

  def initialize
  end

  def self.get_stuff
    doc = Nokogiri::HTML(open("http://www.gw2db.com/items/armor/coats?filter-filter-item-type=3&filter-item-rarity=6&filter-item-armor-weight-type=2&filter-item-armor-type=3&filter-item-minimum-required-level=80&filter-item-maximum-required-level=80"))

    items = {}

    doc.css('.gwitem').map do |link|
      url = "http://www.gw2db.com#{link['href']}"

      page = Nokogiri::HTML(open url)
      puts page.css('.db-defense').text
      # stat = page.css('.db-stat').content

      # items.merge({:name => link.content, :href => url, :defense => defense, :stat => stat})
    end

    # items.each do |item|
    #   item
    #   #
    # end
  end
end




# "http://www.gw2db.com/items/armor/coats?filter-filter-item-type=3&filter-item-rarity=6&filter-item-armor-weight-type=2&filter-item-armor-type=3&filter-item-minimum-required-level=80&filter-item-maximum-required-level=80"
