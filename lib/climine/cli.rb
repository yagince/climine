require 'thor'
require 'climine/redmine'
require 'climine/config'
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
  }
end
