require 'net/http'
require 'uri'
require 'cgi'
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
  def create_issue issue
    post(build_url("/issues.json"), {issue: issue})
  end
  def user id, query={}
    get(build_url("/users/#{id}.json", query))
  end
  def users query={}
    get(build_url("/users.json", query))
  end
  def project id, query={}
    get(build_url("/projects/#{id}.json", query))
  end
  def projects query={}
    get(build_url("/projects.json", query))
  end
  def trackers
    get(build_url("/trackers.json"))
  end
  def statuses
    get(build_url("/issue_statuses.json"))
  end
  def members id
    get(build_url("/projects/#{id}/memberships.json"))
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
  def post url, content
    uri = URI(url)

    req = Net::HTTP::Post.new uri, initheader = {'Content-Type' =>'application/json'}
    req.body = content.to_json

    res = Net::HTTP.start(uri.host, uri.port, use_ssl: (uri.scheme == "https")) do |http|
      http.request req
    end

    json = case res.code.to_i
           when 201
             JSON.parse(res.body)
           else
             { error: true }
           end
    Hashie::Mash.new json
  end

  def build_url path, query={}
    query[:key] = config.apikey
    params = query.map{|(key, value)| "#{key}=#{CGI.escape(value.to_s)}"}.join("&")
    "#{config.url}#{path}?#{params}"
  end
end
