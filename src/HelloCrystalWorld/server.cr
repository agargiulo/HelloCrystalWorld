require "socket"
require "colorize"

module HelloCrystalWorld
  class Server
    def initialize(@host, @port)
      @server = TCPServer.new @host, @port
    end

    def listen
      loop { spawn process(@server.accept) }
    end

    def process(client)
      client_addr = "#{client.peeraddr.ip_address}:#{client.peeraddr.ip_port}"
      puts "#{client_addr} connected".colorize(:magenta)
      while msg = client.read_line
        puts "#{client_addr} msg '#{msg.chop}'".colorize(:light_cyan)
        client << msg
      end

    rescue IO::EOFError
      puts "#{client_addr} dissconnected".colorize(:magenta)

    ensure
      client.close
    end
  end

end
