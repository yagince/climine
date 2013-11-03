require 'net/http'
require 'uri'

module Climine::Command
  module Issue
    def self.included base
      base.class_eval do

        desc "issues", "get Redmine Issues"
        def issue
          config = Climine::Config.new
          res = Net::HTTP.get_response(URI.parse("#{config.url}/issues.json?key=#{config.apikey}"))
          case res.code.to_i
          when 200
            puts res.body
          else
            puts "Error"
          end
        end

      end
    end
  end
end
