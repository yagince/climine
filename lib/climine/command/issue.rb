require "date"

module Climine::Command
  module Issue
    def self.included base
      base.class_eval {

        desc "issue [TICKET_NO]", "get Redmine Issues."
        option :limit, type: :numeric, aliases: '-l', banner: "LIMIT", desc: "limit of search result (default: 25)", deafult: 25
        option :offset, type: :numeric, aliases: '-o', banner: "OFFSET", desc: "page of seach result(0 origin) (default: 0)"
        option :project_id, type: :numeric, aliases: '-p', banner: "PROJECT_ID", desc: "id of RedmineProject ( Please search by `climine project` ) (default: all project)"
        option :assigned_to_id, type: :numeric, aliases: '-u', banner: "USER_ID", desc: "ID of the user being assigned ( Please search by `climine user` )"
        option :created_on, type: :string, aliases: '-c', banner: "CREATED_DATE", desc: "ex) >=2013-10-01, >2013-10-01, <2013-10-01, 2013-10-01"
        option :updated_on, type: :string, aliases: '-r', banner: "LAST_UPDATED_DATE", desc: "ex) >=2013-10-01, >2013-10-01, <2013-10-01, 2013-10-01"
        option :before_week, type: :numeric, aliases: '-w', banner: "WEEKS", desc: "search tickets that has been updated in the last X weeks"
        def issue(id=nil)
          if id
            render :issue, redmine.issue(id)
          else
            render :issues, redmine.issues(before_weeek_to_update_date(options.to_hash))
          end
        end

        no_commands {
          def before_weeek_to_update_date option
            if weeks = option["before_week"]
              option["updated_on"] = ">=#{(Date.today - (weeks * 7)).strftime('%Y-%m-%d')}"
              option.delete "before_week"
            end
            option
          end
        }

      }
    end
  end
end
