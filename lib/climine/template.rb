class Climine::Template
  class << self
    def issue
      self.load(:issue)
    end

    def load name
      File.read("#{File.expand_path(File.dirname(__FILE__))}/template/#{name}.erb")
    end
  end
end
