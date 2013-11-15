require "spec_helper"

describe "Hawking" do
  before do
    $stdout.stub(:write).and_return nil
  end

  it "storing a job" do
    Hawking.job "example" do |data|
      puts "Some example with #{data.inspect}"
    end

    jobs = Hawking.jobs

    jobs.should be_a(Hash)
    jobs.keys.should include("example")

    jobs["example"].should be_a(Proc)
  end

  it "queuing data" do
    server = TCPServer.open "127.0.0.1", 4481

    hawking = Hawking::Queue.new
    hawking.put "example", data: "john@example.org"

    data = JSON.parse server.accept.gets, symbolize_names: true

    server.close

    data.should be_a(Hash)
    data.keys.should include(:queue, :data)

    expect(data[:queue]).to eq "example"
    expect(data[:data]).to eq data: "john@example.org"
  end

  it "works" do
    Hawking.job "example" do |data|
      puts "Some example with #{data.inspect}"
    end

    server = TCPServer.open "127.0.0.1", 4481

    hawking = Hawking::Queue.new
    hawking.put "example", data: "john@example.org"

    Hawking.work_jobs server

    server.close
  end
end
