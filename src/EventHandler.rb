require 'securerandom'

class EventHandler
    attr_reader :handlers

    def initialize
      @handlers = []
    end

    # Block passed is another block that is to be called by all subscribers
    #
    def subscribe(&block)
      h = Hash.new
      key = SecureRandom.uuid.to_sym
      h[key] = block.call
      @handlers << h
      key
    end

    # This block is just an id to the required unsubscribed block id
    #
    def unsubscribe(&block)
      id = block.call
      l = @handlers.select { |h| h.first.first == id }
      @handlers.delete(l.first)
    end

    def broadcast(*args)
      @handlers.each do |h|
        h.each do |_,v|
          v.call(args)
        end
      end
      true
    end
end