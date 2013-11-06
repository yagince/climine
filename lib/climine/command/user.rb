module Climine::Command
  module User
    def self.included base
      base.class_eval {

        desc "user [ID]", "get Redmine Users"
        option :name, type: :string, aliases: '-n', banner: "NAME", desc: "filter users on their login, firstname, lastname and mail"
        def user(id=nil)
          if id
            render :user, redmine.user(id)
          else
            render :users, redmine.users(options.to_hash)
          end
        end

      }
    end
  end
end
