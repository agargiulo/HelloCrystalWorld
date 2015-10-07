require "socket"

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
      puts "#{client_addr} connected"
      while msg = client.read_line
        puts "#{client_addr} msg '#{msg.chop}'"
        client << msg
      end

    rescue IO::EOFError
      puts "#{client_addr} dissconnected"

    ensure
      client.close
    end
  end

end
