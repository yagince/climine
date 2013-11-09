module Climine::Command
  module Tracker
    def self.included base
      base.class_eval {

        desc "tracker", "get Redmine Trackers."
        def tracker
          render :trackers, redmine.trackers
        end

      }
    end
  end
end
