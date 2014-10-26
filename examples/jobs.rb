Hawking::Job.put("send.email") do |data|
  puts "Sending email to #{data[:email]}"
end
