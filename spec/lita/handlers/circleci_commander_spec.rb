require "spec_helper"

RSpec.describe Lita::Handlers::CircleciCommander, lita_handler: true do
  context "rebuild" do
    it { is_expected.to route("#{robot.mention_name}: rebuild 123").to :rebuild }

    let(:rebuild_message) do
      instance_double(Lita::Message, "message", body: "rebuild 123")
    end

    let(:response) { instance_double(Lita::Response, "response", user: user, message: rebuild_message) }

    it "tells who is rebuilding" do
      subject.ci_server = instance_double(Lita::Handlers::CircleciCommander::CircleCi, "circleci",
                                          rebuild: true)
      expect(response).to receive(:reply).with("#{user.name} is rebuilding #123.")

      subject.rebuild(response)
    end

    it "posts rebuild to circle ci" do
      allow(response).to receive(:reply)
      circleci = instance_double(Lita::Handlers::CircleciCommander::CircleCi, "circleci", rebuild: true)
      subject.ci_server = circleci
      expect(circleci).to receive(:rebuild).with "123"

      subject.rebuild(response)
    end

    it "tells about errors calling the circle api" do
      subject.ci_server = instance_double(Lita::Handlers::CircleciCommander::CircleCi, "circleci",
                                          rebuild: false, name: "CircleCi")
      allow(response).to receive(:reply).with("#{user.name} is rebuilding #123.")
      expect(response).to receive(:reply).with("Error talking to CircleCi :(")

      subject.rebuild(response)
    end
  end
end
