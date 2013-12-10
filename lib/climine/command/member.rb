module Climine::Command
  class Member < Base
    desc "list", "get Project Members"
    option :project_id, type: :numeric, aliases: '-p', banner: "PROJECT_ID", required: true, desc: "see) http://www.redmine.org/projects/redmine/wiki/Rest_Memberships#GET"
    def list
      render :members, redmine.members(options["project_id"])
    end
  end
end
