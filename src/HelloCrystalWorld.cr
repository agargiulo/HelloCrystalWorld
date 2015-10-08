require "./HelloCrystalWorld/version"
require "./HelloCrystalWorld/server"
require "./HelloCrystalWorld/client"
require "colorize"

module HelloCrystalWorld
  def self.run_server(host, port)
    puts "This is version #{VERSION} -- SERVER --".colorize(:yellow)

    server = Server.new(host, port)
    puts "Listening on #{host}:#{port}".colorize(:cyan)
    server.listen
  end

  def self.run_client(host, port)
    puts "This is version #{VERSION} -- CLIENT --".colorize(:yellow)

    client = Client.new(host, port)
    puts "Attempting to contact the server at #{host}:#{port}".colorize(:light_yellow)
    10.times do |i|
      client.puts "#{i}".colorize(:red)
      puts "server response #{client.gets}".colorize(:green)
      sleep 0.5
    end
  end
end

exit 1 unless ARGV
flag = ARGV.first
if flag == "--server" || flag == "-s"
  host, port = ARGV[1].split(":")
  HelloCrystalWorld.run_server(host, port.to_i)
else
  host, port = ARGV.first.split(":")
  HelloCrystalWorld.run_client(host, port.to_i)
end
