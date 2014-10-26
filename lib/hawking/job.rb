module Hawking
  class Job
    class << self
      def put(queue, &block)
        @jobs = { "#{queue}" => block }
      end

      def all
        @jobs
      end
    end
  end
end
