# frozen_string_literal: true

require "http"
require "socket"

require "goru/scheduler"

require_relative "../../support/server"

RSpec.describe "writes using a bridge" do
  let(:server) {
    Server.new
  }

  it "handles io" do
    server.start

    # wait a second for the server to start
    sleep(0.25)

    statuses = 3.times.map {
      HTTP.get("http://localhost:4242").status.to_i
    }

    server.stop

    expect(statuses.count).to eq(3)
    expect(statuses.uniq.count).to eq(1)
    expect(statuses.uniq[0]).to eq(204)
  end
end
