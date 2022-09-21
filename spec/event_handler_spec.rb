require 'spec_helper'

describe EventHandler do
    let(:event_handler) { EventHandler.new }
    let(:handler) { |x| "Handler" }

    describe '#subscribe' do
      it 'can receive the new block' do
        expect(event_handler).to receive(:subscribe) do |&block|
          expect(block.call).to eql("Handler")
          expect(block).to be_a(Proc) 
        end
        event_handler.subscribe { handler }
      end

      it 'stores the block' do
        event_handler.subscribe { handler }
        expect(event_handler.handlers.length).to eq(1)
      end
    end

    describe '#unsubscribe' do
      it 'removes the block' do
        @handler = handler
        event_handler.subscribe { @handler }
        h = event_handler.subscribe { @handler }
        event_handler.unsubscribe { h }
        expect(event_handler.handlers.length).to eq(1)
      end
    end

    describe '#broadcast' do
    end

end