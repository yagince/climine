require "hashie"
require "yaml"

class Climine::Config < Hashie::Mash
  def initialize
    super YAML.load_file(ENV['CLIMINE_CONF'] || 'config.yml')
  end
end
