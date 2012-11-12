module Scraper
  class ConnectionManager
    def initialize
      # Set Configurations Parameters
      apply_config

      # Build Headers
      build_headers
    end

    def login(email, password)
      puts "Login_patron >> about to do this"

      response = session(@login_url).post("", {email: email,
                                               password: password,
                                               redirect_uri: 'http://tradingpost-live.ncplatform.net/authenticate?source=%2F',
                                               game_code: 'gw2'})

      handle_response(response)
    end

    def get(page, params)
      puts "Get >> about to do this"

      page = 'trends' if page.blank?
      request_url = "/ws/#{page}"
      response = session.request(:get, request_url, @headers, { query: params })

      handle_response(response)
    end

    private
    def apply_config
      config = YAML::load( File.open('config/scraper.yml'))

      @referer ||= config['login_referer']
      @login_url = config['login_url']
      @base_request_url = config['base_request_url']
    end

    def build_headers
      @headers = {
        'Accept' => 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
        'Accept-Language' => 'en-US,en;q=0.8',
        'Accept-Charset' => 'ISO-8859-1,utf-8;q=0.7,*;q=0.3',
        'Accept-Encoding' => 'gzip,deflate,sdch',
        'Cache-Control' => 'max-age=0',
        'Connection' => 'keep-alive',
        'Content-Type' => 'application/x-www-form-urlencoded',
        'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.11 (KHTML, like Gecko) Chrome/23.0.1271.64 Safari/537.11',
        'Referer' => @referer
      }
    end

    def handle_response(response)
      if response.status < 400
        @referer = response.url

        if response.headers['Content-Encoding'] == 'gzip'
          Zlib::GzipReader.new(StringIO.new(response.body.to_s)).read
        else
          response.body
        end
      else
        error_message = %{
          Response URL: #{response.url}
          Response Status: #{response.status}
          Response Headers: #{response.headers}
        }
        raise error_message
      end
    end

    def session(base_url = @base_request_url)
      @session = Patron::Session.new unless @session.present?
      @session.timeout = 10
      @session.handle_cookies
      @session.base_url = base_url

      @headers.each do |key, value|
        @session.headers[key] = value
      end

      @session.enable_debug "/tmp/patron.debug" unless Rails.env.production?
      @session
    end
  end
end
