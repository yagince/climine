# -*- coding: utf-8 -*-
module Climine::Command
  module Issue
    def self.included base
      base.class_eval {

        desc "issue [TICKET_NO]", "get Redmine Issues."
        option :limit, type: :numeric, aliases: '-l', banner: "LIMIT", desc: "limit of search result (default: 25)", deafult: 25
        option :offset, type: :numeric, aliases: '-o', banner: "OFFSET", desc: "page of seach result(0 origin) (default: 0)"
        option :project_id, type: :numeric, aliases: '-p', banner: "PROJECT_ID", desc: "id of RedmineProject ( Please search by `climine project` ) (default: all project)"
        option :assigned_to_id, type: :numeric, aliases: '-u', banner: "USER_ID", desc: "ID of the user being assigned ( Please search by `climine user` )"
        def issue(id=nil)
          if id
            render :issue, redmine.issue(id)
          else
            render :issues, redmine.issues(options.to_hash)
          end
        end

      }
    end
  end
end
