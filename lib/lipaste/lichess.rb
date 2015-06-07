require "net/http"
require "uri"

module Lipaste
  class Lichess
    HOST = "http://en.lichess.org"
    LOGIN_COOKIE_NAME = "lila2"

    def self.login(username, password)
      uri = get_uri "login"
      res = Net::HTTP.post_form uri, username: username, password: password
      cookie_headers = res.get_fields "set-cookie"
      matches = cookie_headers.map {|c| c.match /^([^=]+)=([^;]+)/}
      cookies = matches.map {|match| {name: match[1], value: match[2]}}
      login_cookie = cookies.select {|cookie| cookie[:name] == LOGIN_COOKIE_NAME}
      login_cookie.pop[:value]
    end

    def self.upload(login_cookie, pgn)
      uri = get_uri "import"
      http = Net::HTTP.new uri.host
      request = Net::HTTP::Post.new uri.request_uri
      request.set_form_data pgn: pgn
      request["Cookie"] = "#{LOGIN_COOKIE_NAME}=#{login_cookie}" if login_cookie
      response = http.request request

      if response.code == "429"
        STDERR.puts "Your account is currently rated limited by Lichess, try waiting a couple minutes"
        exit 1
      elsif response.code != "303"
        STDERR.puts "Error uploading to Lichess"
        STDERR.puts response.code
        STDERR.puts response.body
        exit 1
      end

      paste_route = response.to_hash["location"][0]
      return get_uri(paste_route).to_s
    end

    def self.get_uri(route)
      URI.parse "#{HOST}/#{route.sub(/^\//, "")}"
    end
  end
end
