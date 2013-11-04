require 'net/http'
require 'uri'
require 'json'
require "hashie"

class Climine::Redmine
  attr_reader :config

  def initialize config
    @config = config
  end

  def issue id, query={}
    get(build_url("/issues/#{id}.json", query))
  end
  def issues query={}
    get(build_url("/issues.json", query))
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

  def build_url path, query
    query[:key] = config.apikey
    params = query.map{|(key, value)| "#{key}=#{value}"}.join("&")
    "#{config.url}#{path}?#{params}"
  end
end
