require "net/http"
require "uri"
require "climine/template"
require "erb"
require "time"
require "pp"

module Climine::Command
  module Issue
    def self.included base
      base.class_eval {

        desc "issues", "get Redmine Issues"
        def issue(id=nil)
          erb = ERB.new(Climine::Template.issue)
          (id ? [redmine.issue(id)] : redmine.issues.issues).each {|issue|
            puts erb.result(binding) unless issue.error
          }
        end

      }
    end
  end
end
