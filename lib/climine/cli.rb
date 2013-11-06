require 'thor'
require 'climine/redmine'
require 'climine/config'
require 'climine/template'
require 'climine/command/config'
require 'climine/command/issue'

class Climine::CLI < Thor
  include Climine::Command::Config
  include Climine::Command::Issue

  desc "hello NAME", "say hello to NAME"
  def hello(name)
    puts "Hello #{name}"
    puts Climine::Config.new.url
    puts Climine::Config.new.apikey
  end

  no_commands {
    def redmine
      @redmine ||= Climine::Redmine.new(Climine::Config.new)
    end
    def render template_name, response
      unless response.error
        res = response
        puts Climine::Template.build(Climine::Template.send(template_name)).result(binding)
      else
        puts "Error"
      end
    end
  }
end
