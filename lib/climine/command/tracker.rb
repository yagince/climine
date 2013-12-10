module Climine::Command
  class Tracker < Base
    desc "list", "get Redmine Trackers."
    def list
      render :trackers, redmine.trackers
    end
  end
end
