require "./HelloCrystalWorld/*"

module HelloCrystalWorld
  host, port = ARGV.first.split(":")
  puts "This is version #{VERSION}"

  server = Server.new(host, port)
  puts "Listeing on http://#{host}:#{port}"
  server.listen
end
