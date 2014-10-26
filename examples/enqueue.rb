require "hawking"

hawking = Hawking::Queue.new
hawking.put("send.email", email: "hello@example.com")
