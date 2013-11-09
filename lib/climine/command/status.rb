require "hashie"

module Climine::Command
  module Status
    def self.included base
      base.class_eval {

        desc "status", "get Redmine IssueStatuses."
        option :table, type: :boolean, aliases: '-t', desc: "default asc. ex) 'id,category:desc,updated_on'", default: false
        def status
          unless options[:table]
            render :statuses, redmine.statuses
          else
            render_table redmine.statuses.issue_statuses.map{|status|
              Hashie::Mash.new(
                id: status.id,
                name: status.name,
                is_default: status.is_default,
                is_closed: status.is_closed
              )
            }.sort{|a,b| a.id - b.id}
          end
        end

      }
    end
  end
end
