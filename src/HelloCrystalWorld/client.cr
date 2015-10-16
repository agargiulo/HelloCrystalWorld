require "socket"

module HelloCrystalWorld
  class Client
    def initialize(@host, @port)
      @socket = TCPSocket.new @host, @port
    end

    def puts(message)
      @socket.puts message
    end

    def gets
      @socket.gets
    end
  end

  class HTTPClient
    def initialize(@host, @port)
      @client = Client.new(@host, @port)
    end

    def get(path : String)
      localhost = "localhost"
      request = "GET /#{path} HTTP/1.1
Host: #{localhost}\r
User-Agent: HelloCrystalWorld\r
Accept: text/html\r\n\r\n"
      @client.puts(request)
      response = ""
      while msg = @client.gets
        response += msg
      end
      response
    end
  end
end
