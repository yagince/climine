require 'erb'

module Climine::Command
  module Config
    CONFIG = "config.yml"
    TEMPLATE = <<-ERB
url: <%= options[:url] %>
apikey: <%= options[:key] %>
    ERB

    def self.included base
      base.class_eval do

        desc "init ", "initialize config.yml"
        option :url, required: true, type: :string, aliases: '-u', banner: "RedmineURL", desc: "Your Redmine's URL"
        option :key, required: true, type: :string, aliases: '-k', banner: "API-Access-Key", desc: "Your API Access Key"
        def init
          open(CONFIG, 'w'){|file| file.write(ERB.new(TEMPLATE).result(binding)) }
          puts "create [ #{File.expand_path(CONFIG)} ]"
        end

      end
    end
  end
end
