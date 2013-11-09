module Climine::Command
  class Project < Base
    default_command :project

    desc "project [PROJECT_ID]", "get Redmine Projects."
    def project(id=nil)
      if id
        render :project, redmine.project(id)
      else
        render :projects, redmine.projects(options.to_hash)
      end
    end
  end
end
