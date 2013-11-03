require 'thor'
require 'climine/command/config'
require 'climine/config'

class Climine::CLI < Thor
  include Climine::Command::Config

  desc "hello NAME", "say hello to NAME"
  def hello(name)
    puts "Hello #{name}"
    puts Climine::Config.new.url
    puts Climine::Config.new.apikey
  end
end
