require "erb"

class Climine::Template

  def initialize name
    internal_file_path = self.class.file_path(name)
    @path = File.exist?(internal_file_path) ? internal_file_path : name.to_s
  end

  def exist?
    File.exist?(@path)
  end

  def build
    ERB.new(load, nil, "-")
  end

  private
  def load
    File.read(@path)
  end

  class << self
    def file_path name
      "#{File.expand_path(File.dirname(__FILE__))}/template/#{name}.erb"
    end
  end
end
