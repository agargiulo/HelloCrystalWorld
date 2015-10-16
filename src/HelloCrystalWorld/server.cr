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
      resp = "Hello, World!\n"
      while resq = client.read_line
        break if resq.chomp == ""
        puts "#{client_addr} msg '#{resq.chomp}'".colorize(:light_cyan)
      end
      header = "HTTP/1.1 200 OK
Content-Length: #{resp.size}\r
Content-Type: text/html\r"

      client << "#{header}\r\n\r\n#{resp}\r\n"

    rescue IO::EOFError
      puts "#{client_addr} dissconnected".colorize(:magenta)

    ensure
      client.close
    end
  end

end
