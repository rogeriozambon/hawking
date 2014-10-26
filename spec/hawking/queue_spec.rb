require "spec_helper"

describe "Hawking::Queue" do
  it "raise an exception when missing arguments" do
    server = TCPServer.open("127.0.0.1", 4481)

    queue = Hawking::Queue.new

    expect { queue.put }.to raise_error
    expect { queue.put("job.test") }.to raise_error

    server.close
  end

  it "sending data to queue" do
    server = TCPServer.open("127.0.0.1", 4481)

    queue = Hawking::Queue.new
    queue.put("job.test", "some test")

    received = JSON.parse(server.accept.gets, symbolize_names: true)

    expect(received).to eq({ data: "some test", queue: "job.test" })

    server.close
  end
end
