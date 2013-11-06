require "erb"

class Climine::Template

  def initialize name
    @name = name
  end

  def exist?
    File.exist?(self.class.file_path(@name))
  end

  def build
    self.class.build load
  end

  private
  def load
    File.read(self.class.file_path(@name))
  end

  class << self
    def exist? name
      File.exist?(self.file_path(name))
    end

    def load name
      File.read(self.file_path(name))
    end

    def build template
      ERB.new(template, nil, "-")
    end

    def file_path name
      "#{File.expand_path(File.dirname(__FILE__))}/template/#{name}.erb"
    end
  end
end
