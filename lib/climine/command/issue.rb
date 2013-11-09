require "date"

module Climine::Command
  module Issue
    def self.included base
      base.class_eval {

        desc "issue [TICKET_NO]", "get Redmine Issues. see) http://www.redmine.org/projects/redmine/wiki/Rest_Issues#Listing-issues"
        option :sort, type: :string, aliases: '-s', banner: "SORT_KEYS", desc: "default asc. ex) 'id,category:desc,updated_on'"
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

        desc "issue_new", "new Issue"
        def issue_new
          # project
          projects = sort_by_id redmine.projects.projects
          projects.each{|project| puts "#{project.id} : #{project.name}" }
          project_id = ask("Which project?", limited_to: projects.map{|project| project.id.to_s})

          # tracker
          trackers = sort_by_id redmine.trackers.trackers
          trackers.each{|tracker| puts "#{tracker.id} : #{tracker.name}" }
          tracker_id = ask("Which tracker?", limited_to: trackers.map{|tracker| tracker.id.to_s})

          # status
          statuses = sort_by_id redmine.statuses.issue_statuses
          statuses.each{|status| puts "#{status.id} : #{status.name}" }
          status_id = ask("Which status? (empty is default)")

          # assigned user
          members = sort_by_id redmine.members(project_id).memberships
          members.each{|member| puts "#{member.user.id} : #{member.user.name}"}
          user_id = ask("Who do you assigned?")

          # subject
          subject = ask_not_empty("subject > ")
          # description
          description = ask_not_empty("description > ")

          res = redmine.create_issue(
            project_id: project_id,
            tracker_id: tracker_id,
            status_id: status_id,
            assigned_to_id: user_id,
            subject: subject,
            description: description
          )

          unless res.error
            render :issue, res
          else
            say "Error! (Issue was not created)", :red
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

          def ask_not_empty statement
            answer = nil
            until answer
              answer = ask(statement)
              answer = answer.empty? ? nil : answer
              say "! #{statement} is must not be empty", :magenta unless answer
            end
            answer
          end
        }

      }
    end
  end
end
