require 'net/http'
require 'json'
require 'base64'

module Github
  class Client
    API = 'https://api.github.com'.freeze

    def initialize name, token, max
      @org_name = name
      @token = token
      @max = max
    end

    def contents_urls
      get_repos = request_with_token "#{API}/orgs/#{@org_name}/repos?per_page=#{@max}"
      res = http.request get_repos

      unless res.is_a? Net::HTTPSuccess
        warn res.body
        raise 'HTTP Error!'
      end

      to_contents_url res
    end

    def get_file url
      get_gemfile = request_with_token url
      res = http.request get_gemfile

      Base64.decode64 JSON.parse(res.body)['content'] if res.is_a? Net::HTTPSuccess
    end

    private

    def request_with_token url
      req = Net::HTTP::Get.new URI url
      req['Authorization'] = "token #{@token}" if @token
      req
    end

    def to_contents_url res_repos
      JSON.parse(res_repos.body)
          .map { |r| [r['name'], r['contents_url']] }
    end

    def http
      @http ||= init
    end

    def init
      uri = URI API
      http = Net::HTTP.new uri.host, uri.port
      http.use_ssl = uri.scheme == 'https'
      http.start
    end
  end
end
