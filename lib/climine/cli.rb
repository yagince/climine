require 'thor'
require 'climine/command/config'

class Climine::CLI < Thor
  include Climine::Command::Config

  desc "hello NAME", "say hello to NAME"
  def hello(name)
    puts "Hello #{name}"
  end
end
