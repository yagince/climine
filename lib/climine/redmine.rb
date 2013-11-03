require 'net/http'
require 'uri'
require 'json'
require "hashie"

class Climine::Redmine
  attr_reader :config

  def initialize config
    @config = config
  end

  def issue id
    get("#{config.url}/issues/#{id}.json?key=#{config.apikey}")
  end
  def issues
    get("#{config.url}/issues.json?key=#{config.apikey}")
  end

  private
  def get url
    res = Net::HTTP.get_response(URI.parse(url))
    json = case res.code.to_i
           when 200
             JSON.parse(res.body)
           else
             { error: true }
           end
    Hashie::Mash.new json
  end
end
