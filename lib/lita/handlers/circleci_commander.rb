require "net/http"

module Lita
  module Handlers
    class CircleciCommander < Handler
      attr_writer :ci_server

      # insert handler code here
      route /^rebuild/, :rebuild, command: true, help: { "rebuild 1234" => "Retry the specified build."}

      def rebuild(response)
        build_id = response.message.body.split.last
        response.reply "#{response.user.name} is rebuilding ##{build_id}."
        ci_server.rebuild(build_id.to_i) || response.reply("Error talking to CircleCi :(")
      end

      def ci_server
        @ci_server ||= CircleCi.new
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
