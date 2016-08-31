require "spec_helper"

describe Lita::Handlers::CircleciCommander, lita_handler: true do
  context "rebuild" do
    it { is_expected.to route("#{robot.mention_name}: rebuild #123").to :rebuild }

    let(:rebuild_message) {
      instance_double("Lita::Message", "message", body: "rebuild #123")
    }

    let(:response) { instance_double("Lita::Response", "response", user: user, message: rebuild_message) }

    it "tells who is rebuilding" do
      subject.circle = spy("circleci")
      expect(response).to receive(:reply).with("#{user.name} is rebuilding #123.")

      subject.rebuild(response)
    end

    it "posts rebuild to circle ci" do
      circleci = instance_double("Lita::Handlers::CircleciCommander::CircleCi", "circleci", rebuild: true)
      subject.circle = circleci
      expect(circleci).to receive(:rebuild).with 123
      expect(response).to receive(:reply)

      subject.rebuild(response)
    end
  end
end
