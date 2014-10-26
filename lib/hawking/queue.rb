module Hawking
  class Queue
    def initialize
      @socket = TCPSocket.open("127.0.0.1", 4481)
    end

    def put(queue, data)
      info = JSON.generate(queue: queue, data: data)

      @socket.write(info)
      @socket.close
    end
  end
end
