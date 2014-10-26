module Hawking
  class Runner
    def initialize
      @server = TCPServer.open("127.0.0.1", 4481)
    end

    def execute
      puts "Working #{jobs.size} jobs: [ #{jobs.keys.join(' ')} ]"

      loop { Hawking::Worker.new(@server).execute }
    end

    def close
      @server.close
    end

    private
    def jobs
      Hawking::Job.all
    end
  end
end
