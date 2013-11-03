require "hashie"
require "yaml"

class Climine::Config < Hashie::Mash
  def initialize
    super YAML.load_file('config.yml')
  end
end
