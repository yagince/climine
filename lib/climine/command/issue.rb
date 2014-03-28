require "date"
require 'tempfile'

module Climine::Command
  class Issue < Base

    desc "list [TICKET_NO]", "get Redmine Issues. see) http://www.redmine.org/projects/redmine/wiki/Rest_Issues#Listing-issues"
    option :sort, type: :string, aliases: '-s', banner: "SORT_KEYS", desc: "default asc. ex) 'id,category:desc,updated_on'"
    option :limit, type: :numeric, aliases: '-l', banner: "LIMIT", desc: "limit of search result (default: 25)", deafult: 25
    option :offset, type: :numeric, aliases: '-o', banner: "OFFSET", desc: "page of seach result(0 origin) (default: 0)"
    option :project_id, type: :numeric, aliases: '-p', banner: "PROJECT_ID", desc: "id of RedmineProject ( Please search by `climine project` ) (default: all project)"
    option :status_id, type: :numeric, banner: "STATUS_ID", desc: "id of issue status. ( Please search by `climine status` ) (default: all status)", default: "*"
    option :assigned_to_id, type: :numeric, aliases: '-u', banner: "USER_ID", desc: "ID of the user being assigned ( Please search by `climine user` )"
    option :created_on, type: :string, aliases: '-c', banner: "CREATED_DATE", desc: "ex) >=2013-10-01, >2013-10-01, <2013-10-01, 2013-10-01"
    option :updated_on, type: :string, aliases: '-r', banner: "LAST_UPDATED_DATE", desc: "ex) >=2013-10-01, >2013-10-01, <2013-10-01, 2013-10-01"
    option :before_week, type: :numeric, aliases: '-w', banner: "WEEKS", desc: "search tickets that has been updated in the last X weeks"
    option :template, type: :string, aliases: '-t', banner: "TEMPLATE_PATH", desc: "rendering by given template"
    def list
      render (options["template"] || :issues), redmine.issues(before_weeek_to_update_date(options.to_hash))
    end

    desc "get [TICKET_NO]", "get Redmine Issues. see) http://www.redmine.org/projects/redmine/wiki/Rest_Issues#Listing-issues"
    option :template, type: :string, aliases: '-t', banner: "TEMPLATE_PATH", desc: "rendering by given template"
    def get(id=nil)
      say("required ticket number!", :red) unless id
      render (options["template"] || :issue), redmine.issue(id)
    end

    desc "new", "create Issue"
    option :project, type: :numeric, aliases: '-p', banner: "PROJECT_ID", desc: "project_id (search by `project` command)"
    option :tracker, type: :numeric, aliases: '-t', banner: "TRACKER_ID", desc: "tracker_id (search by `tracker` command)"
    option :status, type: :numeric, aliases: '-s', banner: "STATUS_ID", desc: "status_id (search by `status` command)"
    option :user, type: :numeric, aliases: '-u', banner: "USER_ID", desc: "user_id (search by `user` command)"
    option :subject, type: :string, banner: "SUBJECT", desc: "ticket title"
    option :desc, type: :string, banner: "DESCRIPTION", desc: "ticket description"
    def new
      # project
      unless project_id = options["project"]
        projects = sort_by_id redmine.projects.projects
        projects.each{|project| puts "#{project.id} : #{project.name}" }
        project_id = ask("Which project?", limited_to: projects.map{|project| project.id.to_s})
      end
   
      # tracker
      unless tracker_id = options["tracker"]
        trackers = sort_by_id redmine.trackers.trackers
        trackers.each{|tracker| puts "#{tracker.id} : #{tracker.name}" }
        tracker_id = ask("Which tracker?", limited_to: trackers.map{|tracker| tracker.id.to_s})
      end
   
      # status
      unless status_id = options["status"]
        statuses = sort_by_id redmine.statuses.issue_statuses
        statuses.each{|status| puts "#{status.id} : #{status.name}" }
        status_id = ask("Which status? (empty is default)")
      end
   
      # assigned user
      unless user_id = options["user"]
        members = sort_by_id redmine.members(project_id).memberships
        members.each{|member| puts "#{member.user.id} : #{member.user.name}"}
        user_id = ask("Who do you assigned?")
      end
   
      res = redmine.create_issue(
        project_id: project_id,
        tracker_id: tracker_id,
        status_id: status_id,
        assigned_to_id: user_id,
        subject: ask_not_empty("subject > ").force_encoding('utf-8'),
        description: ask_description
      )
   
      unless res.error
        render :issue, res
      else
        say "Error! (Issue was not created)", :red
      end
    end

    desc "update [TICKET_NO]", "update Redmine Issues. see) http://www.redmine.org/projects/redmine/wiki/Rest_Issues#Updating-an-issue"
    option :tracker_id, type: :numeric, aliases: '-t', banner: "TRACKER_ID", desc: "tracker_id (search by `tracker` command)"
    option :status_id, type: :numeric, aliases: '-s', banner: "STATUS_ID", desc: "status_id (search by `status` command)"
    option :user_id, type: :numeric, aliases: '-u', banner: "USER_ID", desc: "user_id (search by `user` command)"
    def update(id=nil)
      say("required ticket number!", :red) and return unless id
      redmine.update_issue id, options
      render :issue, redmine.issue(id)
    end

    desc "start [TICKET_NO]", "update status of issue to ID:2."
    option :tracker_id, type: :numeric, aliases: '-t', banner: "TRACKER_ID", desc: "tracker_id (search by `tracker` command)"
    option :user_id, type: :numeric, aliases: '-u', banner: "USER_ID", desc: "user_id (search by `user` command)"
    def start(id=nil)
      say("required ticket number!", :red) and return unless id
      redmine.update_issue id, options.merge({status_id: 2})
      render :issue, redmine.issue(id)
    end

    desc "close [TICKET_NO]", "update status of issue to ID:5."
    def close(id=nil)
      say("required ticket number!", :red) and return unless id
      redmine.update_issue id, {status_id: 5}
      render :issue, redmine.issue(id)
    end

    desc "finish [TICKET_NO]", "alias for close"
    def finish(id=nil)
      close(id)
    end

    desc "reject [TICKET_NO]", "update status of issue to ID:6."
    def reject(id=nil)
      say("required ticket number!", :red) and return unless id
      redmine.update_issue id, {status_id: 6}
      render :issue, redmine.issue(id)
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

      def ask_description
        editor = config.editor
        if editor.nil? or editor.empty?
          description = ask_not_empty("description > ")
        else
          tmp = Tempfile.new('description_tmp')
          system "#{editor} #{tmp.path}"
          description = open(tmp.path){|f| f.read.force_encoding('utf-8') }
          tmp.unlink
        end
        description
      end
    }
  end
end
