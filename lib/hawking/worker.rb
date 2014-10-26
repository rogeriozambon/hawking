module Hawking
  class Worker
    def initialize(server)
      @server = server
    end

    def execute
      Thread.start(@server.accept) do |listener|
        job = JSON.parse(listener.gets, symbolize_names: true)
        puts "Working on #{job[:queue]} (#{job[:data]})"

        run(job)
      end
    end

    private
    def run(job)
      begin
        Timeout::timeout(20) do
          handler = jobs[job[:queue]]
          handler.call(job[:data])
        end
      rescue Timeout::Error
        raise "The job hit 20 seconds timeout"
      end
    end

    def jobs
      Hawking::Job.all
    end
  end
end
