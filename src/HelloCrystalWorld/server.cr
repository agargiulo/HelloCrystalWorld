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
      resp = ""
      while resq = client.read_line
        break if resq.chop == ""
        puts "#{client_addr} msg '#{resq.chop}'".colorize(:light_cyan)
        resp += resq
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
