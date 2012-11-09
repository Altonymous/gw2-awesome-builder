class Spidy

  def initialize
  end

  def self.get_items
    response = JSON.parse(RestClient.get "http://www.gw2spidy.com/api/v0.9/json/items/0/0?rarity_filter=5&sort_name=asc")

    response['results'].map do |result|
      item_id = result['gw2db_external_id']
      name = result['name'].gsub(/'/, '').parameterize
      name = "-#{name}" unless name.length < 1
      url = "http://www.gw2db.com/items/#{item_id}#{name}"
      extra_data = {'url' => url}
      result.merge(extra_data)
    end

    # response['results'].map do |result|
      # get the ID
      # create a URL for a different site
      # get that site
      # prase that response; save it in a "extra_data" variable and it is a Ruby hash
      # add that response to the "result"

      # result.merge(extra_data)
    # end

    # stuff = JSON.parse(RestClient.get "http://www.gw2db.com/skills/#{}")

    # puts = JSON.parse(RestClient.get "http://www.gw2db.com/skills/#{}")
    # gw2db = 6958


  end

end
