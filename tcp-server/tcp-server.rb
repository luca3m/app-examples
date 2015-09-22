require 'socket'

$should_listen = true
$server = TCPServer.new 2000 # Server bound to port 2000

Signal.trap("USR1") do
    $should_listen = !$should_listen
    puts "should_listen now: #$should_listen"
  end

loop do
  if $should_listen == true
    unless $server
      $server = TCPServer.new 2000
    end
    client = $server.accept    # Wait for a client to connect
    begin
      client.puts "Hello !"
      client.puts "Time is #{Time.now}"
    rescue
    end
    client.close
  else
    if $server
      $server.shutdown
      $server = nil
    end
    sleep 1
  end
end
