require "pp"
require "time"
require "thor"
require "hirb"
require "hirb-unicode"

require "climine/redmine"
require "climine/config"
require "climine/template"
require "climine/command/config"
require "climine/command/issue"
require "climine/command/user"
require "climine/command/project"
require "climine/command/tracker"
require "climine/command/status"

class Climine::CLI < Thor
  include Climine::Command::Config
  include Climine::Command::Issue
  include Climine::Command::User
  include Climine::Command::Project
  include Climine::Command::Tracker
  include Climine::Command::Status

  no_commands {
    def redmine
      @redmine ||= Climine::Redmine.new(Climine::Config.new)
    end
    def render template_name, response
      unless response.error
        template = Climine::Template.new(template_name)
        if template.exist?
          res = response
          puts template.build.result(binding)
        else
          pp response
        end
      else
        say "-- Error or NotFound", :red
      end
    end
    def render_table data
      puts Hirb::Helpers::AutoTable.render(data)
    end
    def sort_by_id ary
      ary.sort{|a,b| a.id - b.id}
    end
  }
end
