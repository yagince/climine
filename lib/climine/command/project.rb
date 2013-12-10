module Climine::Command
  class Project < Base

    desc "get [PROJECT_ID]", "get Redmine Project."
    def get id
      say("required project id!", :red) unless id
      render :project, redmine.project(id)
    end

    desc "list", "get Redmine Projects."
    def list
      render :projects, redmine.projects(options.to_hash)
    end
  end
end
