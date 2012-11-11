class Spidy

  def initialize
    @base_url = "http://www.gw2spidy.com/api/v0.9/json"
  end


  def get_items(type, sub_type)
    results = search_items(type, sub_type)

    results.select! { |item| item if item['restriction_level'] == 80 }

    # Not sure if the filter is working or not, we're getting weird data right now
    # results.select! { |item| item if item['rarity'] == 5 }
    results.map do |result|

      # I do this to filter out bogus items
      item_id = result['gw2db_external_id']
      name = result['name'].gsub(/'/, '').parameterize
      name = "-#{name}" unless name.length < 1
      url = "http://www.gw2db.com/items/#{item_id}#{name}"

      gw2db = Noko.new
      gw2db.get_item(url)

      extra_data = {'url' => url}
      result.merge(extra_data)
    end
  end

  def search_items(type, sub_type)
    @extras = "/items/#{type}/#{sub_type}?sort_name=asc"

    session = Patron::Session.new
    session.base_url = @base_url
    response = session.get @extras

    response = JSON.parse(response.body)
    results = response['results']
  end

end
