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

    client = HTTPClient.new(host, port)
    response = client.get
    header, body = response.split /\r\n\r\n/
    puts header
    puts body
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
