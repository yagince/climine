module Climine::Command
  class Member < Base
    default_command :get

    desc "get", "get Redmine Users"
    option :project_id, type: :numeric, aliases: '-p', banner: "PROJECT_ID", required: true, desc: "see) http://www.redmine.org/projects/redmine/wiki/Rest_Memberships#GET"
    def get
      render :members, redmine.members(options["project_id"])
    end
  end
end
