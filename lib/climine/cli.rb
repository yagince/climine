require "pp"
require "thor"
require "climine/redmine"
require "climine/config"
require "climine/template"
require "climine/command/config"
require "climine/command/issue"
require "climine/command/user"
require "climine/command/project"

class Climine::CLI < Thor
  include Climine::Command::Config
  include Climine::Command::Issue
  include Climine::Command::User
  include Climine::Command::Project

  no_commands {
    def redmine
      @redmine ||= Climine::Redmine.new(Climine::Config.new)
    end
    def render template_name, response
      unless response.error
        if Climine::Template.respond_to?(template_name)
          res = response
          puts Climine::Template.build(Climine::Template.send(template_name)).result(binding)
        else
          pp response
        end
      else
        say "-- Error or NotFound", :red
      end
    end
  }
end
