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
end
