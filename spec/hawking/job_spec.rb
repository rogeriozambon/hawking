require "spec_helper"

describe "Hawking::Job" do
  it "allocating a new job into the jobs queue" do
    Hawking::Job.put("job.test") do |name|
      puts "This test is called: #{name}"
    end

    expect(Hawking::Job.all["job.test"]).to be_a(Proc)
  end

  it "running a allocated job" do
    Hawking::Job.put("job.test") do |name|
      puts "This test is called: #{name}"
    end

    jobs = Hawking::Job.all

    expect { jobs["job.test"].call("running a allocated job") }.to output("This test is called: running a allocated job\n").to_stdout
  end
end
