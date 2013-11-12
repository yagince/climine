module Climine::Command
  class Base < Thor

    no_commands {
      def redmine
        @redmine ||= Climine::Redmine.new(Climine::Config.new)
      end
      def render template_name, response
        unless response.error
          template = Climine::Template.new(template_name)
          if template.exist?
            res = response
            puts template.build.result(binding)
          else
            pp response
          end
        else
          say "-- Error or NotFound", :red
        end
      end
      def render_table data
        puts Hirb::Helpers::AutoTable.render(data)
      end
      def sort_by_id ary
        ary.sort{|a,b| a.id - b.id}
      end
    }
  end
end
