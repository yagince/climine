require 'erb'

module Climine::Command
  class Config < Base
    CONFIG = "climine.yml"
    TEMPLATE = <<-ERB
url: <%= options[:url] %>
apikey: <%= options[:key] %>
<% if options[:editor] -%>
editor: <%= options[:editor] %>
<% end -%>
    ERB

    default_command :init

    desc "init ", "initialize climine.yml"
    option :url, required: true, type: :string, aliases: '-u', banner: "RedmineURL", desc: "Your Redmine's URL"
    option :key, required: true, type: :string, aliases: '-k', banner: "API-Access-Key", desc: "Your API Access Key"
    option :editor, required: false, type: :string, aliases: '-e', banner: "Editor command or path", desc: "Your favorite editor ex) emacs or vim or /usr/bin/emacs etc..."
    def init
      return if File.exist?(CONFIG) and !yes?("Overwrite? [#{CONFIG}] (y/n)", :green)

      open(CONFIG, 'w'){|file| file.write(ERB.new(TEMPLATE, nil, "-").result(binding)) }
      puts "create [ #{File.expand_path(CONFIG)} ]"
    end

  end
end
