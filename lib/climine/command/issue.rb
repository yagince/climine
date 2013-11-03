require 'net/http'
require 'uri'

module Climine::Command
  module Issue
    def self.included base
      base.class_eval {

        desc "issues", "get Redmine Issues"
        def issue(id=nil)
          puts( id ? redmine.issue(id) : redmine.issues )
        end

      }
    end
  end
end
