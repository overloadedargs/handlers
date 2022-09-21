require 'securerandom'

class EventHandler
    attr_reader :handlers

    def initialize
      @handlers = []
    end

    def subscribe(&block)
      h = Hash.new
      key = SecureRandom.uuid.to_sym
      h[key] = block
      @handlers << h
      return key
    end

    # This block is just an id to the required unsubscribed id
    #
    def unsubscribe(&block)
      id = block.call
      l = @handlers.select { |h| p h.first; h.first.first == id }
      @handlers.delete(l.first)
    end
end