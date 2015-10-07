require "./HelloCrystalWorld/*"
require "http/server"

module HelloCrystalWorld
  host, port = ARGV.first.split(":")
  puts "This is version #{VERSION}"
  server = HTTP::Server.new(host, port) do |request|
    puts "#{request.method} #{request.version}"
    puts request.headers
    puts "Body: #{request.body}"
    HTTP::Response.ok "text/plain", "Hello, world!"
  end
  puts "Listeing on http://#{host}:#{port}"
  server.listen
end
