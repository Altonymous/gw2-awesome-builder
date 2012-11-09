class Scraper

  require 'open-uri'
  require 'json'

  def initialize
    apply_config
    @auth = {:email => @email, :password => @password}
    @headers = {:headers => {'Accept-Language' => 'en',
                             'User-Agent' => 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1003.1 Safari/535.19 Awesomium/1.7.1',
                             'X-Requested-With' => 'XMLHttpRequest',
                             'Referer' => 'https://tradingpost-live.ncplatform.net/'}}
  end

  def self.login
    puts "Login >> about to do this"
    response = RestClient.get('https://account.guildwars2.com/login?redirect_uri=http%3A%2F%2Ftradingpost-live.ncplatform.net%2Fauthenticate%3Fsource%3D%252F&game_code=gw2', :headers => @headers, :basic_auth => @auth)
    @cookie = response.cookies
    puts @cookie
    puts response.headers
    # puts response.body, response.code, response.headers.inspect
    # Scraper.get
  end

  def self.get
    puts "Get >> about to do this"
    response = RestClient.get('https://tradingpost-live.ncplatform.net/', )
    puts response.body, response.code, response.headers.inspect
  end

  def apply_config
    config = YAML::load( File.open('config/scraper.yml'))
    @email = config['email']
    @password = config['password']
  end


  def self.spidy
    result = JSON.parse(open("http://www.gw2spidy.com/api/v0.9/json/type/all").read)
    puts response.code
  end
end
