require 'erb'

module Climine::Command
  module Config
    CONFIG = "config.yml"
    TEMPLATE = <<-ERB
url: <%= options[:url] %>
key: <%= options[:key] %>
    ERB

    def self.included base
      base.class_eval do

        desc "init ", "initialize config.yml"
        option :url, required: true, type: :string, aliases: '-u', banner: "RedmineURL", desc: "Your Redmine's URL"
        option :key, required: true, type: :string, aliases: '-k', banner: "API-Access-Key", desc: "Your API Access Key"
        def init
          open(CONFIG, 'w'){|file| file.write(ERB.new(TEMPLATE).result(binding)) }
        end

      end
    end
  end
end
