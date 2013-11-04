require "net/http"
require "uri"
require "climine/template"
require "erb"
require "time"

module Climine::Command
  module Issue
    def self.included base
      base.class_eval {

        desc "issue [TICKET_NO]", "get Redmine Issues."
        option :limit, type: :numeric, aliases: '-l', banner: "LIMIT", desc: "limit of search result (default: 25)", deafult: 25
        option :offset, type: :numeric, aliases: '-o', banner: "OFFSET", desc: "page of seach result(0 origin) (default: 0)"
        option :project_id, type: :numeric, aliases: '-p', banner: "PROJECT_ID", desc: "id of RedmineProject (default: all project)"
        def issue(id=nil)
          if id
            issue = redmine.issue(id)
            puts Climine::Template.build(Climine::Template.issue).result(binding)
          else
            res = redmine.issues(options.to_hash)
            puts Climine::Template.build(Climine::Template.issues).result(binding)
          end
        end

      }
    end
  end
end
