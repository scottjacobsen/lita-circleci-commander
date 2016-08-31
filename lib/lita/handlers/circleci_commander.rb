require "net/http"
require "pry"

module Lita
  module Handlers
    class CircleciCommander < Handler
      attr_writer :circle

      # insert handler code here
      route /^rebuild \#/, :rebuild, command: true, help: { "rebuild" => "Rebuild the last failed build."}

      def rebuild(response)
        build_id = response.message.body.split.last
        response.reply "#{response.user.name} is rebuilding #{build_id}."
        circle.rebuild(build_id.delete("#").to_i) || response.reply("Error talking to CircleCi :(")
      end

      def circle
        @circle ||= CircleCi.new
      end

      Lita.register_handler(self)

      class CircleCi
        def rebuild id
          uri = URI("https://circleci.com/api/v1.1/project/#{vcs}/#{username}/#{project}/#{id}/retry?circle-token=#{token}")
          Net::HTTP.post_form(uri, {}).is_a?(Net::HTTPSuccess)
        end

        def vcs
          ENV["CIRCLECI_VCS_TYPE"]
        end

        def username
          ENV["CIRCLECI_USERNAME"]
        end

        def project
          ENV["CIRCLECI_PROJECT"]
        end

        def token
          ENV["CIRCLECI_TOKEN"]
        end
      end
    end
  end
end
