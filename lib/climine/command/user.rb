module Climine::Command
  class User < Base
    default_command :user

    desc "user [ID]", "get Redmine Users"
    option :name, type: :string, aliases: '-n', banner: "NAME", desc: "filter users on their login, firstname, lastname and mail"
    def user(id=nil)
      if id
        render :user, redmine.user(id)
      else
        render :users, redmine.users(options.to_hash)
      end
    end
  end
end
