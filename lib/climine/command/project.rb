module Climine::Command
  module Project
    def self.included base
      base.class_eval {

        desc "project [PROJECT_ID]", "get Redmine Projects."
        def project(id=nil)
          if id
            render :project, redmine.project(id)
          else
            render :projects, redmine.projects(options.to_hash)
          end
        end

      }
    end
  end
end
