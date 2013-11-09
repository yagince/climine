module Climine::Command
  class Tracker < Base
    default_command :tracker

    desc "tracker", "get Redmine Trackers."
    def tracker
      render :trackers, redmine.trackers
    end
  end
end
