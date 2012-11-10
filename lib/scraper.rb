class Scraper

  require 'open-uri'
  require 'json'


  def initialize(email, password)
    apply_config
    @email = email
    @password = password
    @auth = {email: @email, password: @password}
    @headers = {headers: {
                  'Accept' => 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
                  'Accept-Language' => 'en-US,en;q=0.8',
                  'Accept-Charset' => 'ISO-8859-1,utf-8;q=0.7,*;q=0.3',
                  # 'Accept-Encoding' => 'gzip,deflate,sdch',
                  'Cache-Control' => 'max-age=0',
                  'Connection' => 'keep-alive',
                  'Content-Type' => 'application/x-www-form-urlencoded',
                  'Host' => 'account.guildwars2.com',
                  'Origin' => 'https://account.guildwars2.com',
                  'Referer' => @login_referer,
                  'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.11 (KHTML, like Gecko) Chrome/23.0.1271.64 Safari/537.11'
    }}
  end

  def login_patron
    puts "Login_patron >> about to do this"
    sess = Patron::Session.new
    sess.timeout = 10
    sess.base_url = @login_url
    sess.handle_cookies("/tmp/patron.cookies")
    @headers.each do |key, headers|
      headers.each do |key, value|
        sess.headers[key] = value
      end
    end
    sess.enable_debug "/tmp/patron.debug"

    resp = sess.post("", {email: @email,
                          password: @password,
                          redirect_uri: 'http://tradingpost-live.ncplatform.net/authenticate?source=%2F',
                          game_code: 'gw2'})

    if resp.status < 400
      resp
    else
      raise "It no worky."
    end
  end

  def login_net_http
    puts "Login_net_http >> about to do this"
    response = nil
    uri = URI.parse(@login_url)

    # Setup SSL
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    # Setup the Post Request
    req = Net::HTTP::Post.new(uri.request_uri)

    # Setup Headers
    @headers.each do |key, headers|
      headers.each do |key, value|
        req[key] = value
      end
    end

    # Setup Params
    req.set_form_data(email: @email,
                      password: @password,
                      redirect_uri: 'http://tradingpost-live.ncplatform.net/authenticate?source=%2F',
                      game_code: 'gw2')

    # Start the Request
    Net::HTTP.start(uri.host, uri.port) do |http|
      response = http.request req
    end

    # Handle Response
    case response
    when Net::HTTPSuccess then
      response
    when Net::HTTPRedirection then
      location = response['location']
      warn "redirected to #{location}"
      fetch(location)
    else
      response.value
    end
  end

  def login_rest_client
    puts "Login_rest_client >> about to do this"
    response = RestClient.post(@login_url, {email: @email,
                                            password: @password,
                                            redirect_uri: 'http://tradingpost-live.ncplatform.net/authenticate?source=%2F',
                                            game_code: 'gw2'},
                               @headers
    ) { |response, request, result, &block|
      case response.code
      when 400
        puts response.to_yaml
        puts response.body
      else
        @session_id = response.cookies
      end
    }

    puts response
  end

  def get(page = 'trends', params = '')
    puts "Get >> about to do this"
    request_url = @base_request_url.sub("[:page]", page).sub("[:params]", params)
    response = RestClient.get(request_url, { cookies: {session_id: @session_id} })
    puts response.body, response.code, response.headers.inspect
  end

  def apply_config
    config = YAML::load( File.open('config/scraper.yml'))

    @email = config['email']
    @password = config['password']
    @login_referer = config['login_referer']
    @login_url = config['login_url']
    @base_request_url = config['base_request_url']
  end

  def spidy
    result = JSON.parse(open("http://www.gw2spidy.com/api/v0.9/json/type/all").read)
    puts response.code
  end

  def fetch(uri_str, limit = 10)
    # You should choose a better exception.
    raise ArgumentError, 'too many HTTP redirects' if limit == 0

    response = Net::HTTP.get_response(URI(uri_str))

    case response
    when Net::HTTPSuccess then
      response
    when Net::HTTPRedirection then
      location = response['location']
      warn "redirected to #{location}"
      fetch(location, limit - 1)
    else
      response.value
    end
  end
end


# response = RestClient.get 'http://example.com/action_which_sets_session_id'
# response.cookies
# # => {"_applicatioN_session_id" => "1234"}

# response2 = RestClient.post(
#   'http://localhost:3000/',
#   {param1: "foo"},
#   {cookies: {session_id: "1234"}}
# )
