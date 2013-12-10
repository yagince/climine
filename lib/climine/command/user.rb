module Climine::Command
  class User < Base
    desc "get [ID]", "get Redmine User"
    def get(id=nil)
      say("required user id!", :red) unless id
      render :user, redmine.user(id)
    end

    desc "list", "get Redmine Users"
    option :name, type: :string, aliases: '-n', banner: "NAME", desc: "filter users on their login, firstname, lastname and mail"
    def list
      render :users, redmine.users(options.to_hash)
    end
  end
end
