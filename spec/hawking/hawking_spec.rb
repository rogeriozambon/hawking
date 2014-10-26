require "spec_helper"

describe "Hawking at work" do
  before do
    allow($stderr).to receive(:write).and_return(nil)
    allow($stdout).to receive(:write).and_return(nil)
  end

  it "consuming a allocated job" do
    server = TCPServer.open("127.0.0.1", 4481)

    queue = Hawking::Queue.new
    queue.put("job.test", "some test")

    worker = Hawking::Worker.new(server)
    expect(worker.execute).to be_a(Thread)

    server.close
  end
end
