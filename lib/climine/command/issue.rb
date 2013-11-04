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

        desc "issue [TICKET_NO]", "get Redmine Issues."
        def issue(id=nil)
          if id
            issue = redmine.issue(id)
            puts Climine::Template.build(Climine::Template.issue).result(binding)
          else
            res = redmine.issues
            puts Climine::Template.build(Climine::Template.issues).result(binding)
          end
        end

      }
    end
  end
end
