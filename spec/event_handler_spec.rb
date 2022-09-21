require 'spec_helper'

# Maintaining id list?
#
describe EventHandler do
    let(:event_handler) { EventHandler.new }

    before do
      @handler = ->(args) { p args; }
    end

    describe '#subscribe' do
      it 'can receive the new block' do
        expect(event_handler).to receive(:subscribe) do |&block|
          expect(block).to be_a(Proc) 
        end
        event_handler.subscribe { @handler }
      end

      it 'stores the block' do
        event_handler.subscribe { @handler }
        expect(event_handler.handlers.length).to eq(1)
      end
    end

    describe '#unsubscribe' do
      it 'removes the block' do
        event_handler.subscribe { @handler }
        h = event_handler.subscribe { @handler }
        event_handler.unsubscribe { h }
        expect(event_handler.handlers.length).to eq(1)
      end
    end

    describe '#broadcast' do
      it 'can call all the blocks with arguments' do
        event_handler.subscribe { @handler }
        event_handler.subscribe { @handler }
        expect(event_handler.broadcast(1,2,3)).to eq(true)
      end
    end

end