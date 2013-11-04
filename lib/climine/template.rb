require "erb"

class Climine::Template
  class << self
    def issue
      self.load(:issue)
    end
    def issues
      self.load(:issues)
    end

    def load name
      File.read("#{File.expand_path(File.dirname(__FILE__))}/template/#{name}.erb")
    end

    def build template
      ERB.new(template, nil, "-")
    end
  end
end
