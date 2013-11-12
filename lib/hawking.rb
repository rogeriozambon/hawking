require "socket"
require "json"
require "timeout"

module Hawking
  extend self

  VERSION = "0.1"

  def run
    puts "Working #{@@jobs.size} jobs: [ #{@@jobs.keys.join(' ')} ]"

    server = TCPServer.open "127.0.0.1", 4481

    loop { work_jobs server }
  end

  def work_jobs(server)
    Thread.start(server.accept) do |listener|
      job = JSON.parse listener.gets, symbolize_names: true

      puts "Working on #{job[:queue]} (#{job[:data]})"

      begin
        Timeout::timeout(120) do
          handler = @@jobs[job[:queue]]
          handler.call(job[:data])
        end
      rescue Timeout::Error
        raise "The job hit 120 seconds timeout"
      end
    end
  end

  def job(queue, &block)
    @@jobs ||= {}
    @@jobs[queue] = block
  end

  def jobs
    @@jobs
  end

  class Queue
    def initialize
      @socket = TCPSocket.open "127.0.0.1", 4481
    end

    def put(queue, data)
      info = JSON.generate :queue => queue, :data => data

      @socket.write info
      @socket.close
    end
  end
end
