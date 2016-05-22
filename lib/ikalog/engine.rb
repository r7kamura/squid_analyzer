require "ikalog/capture_source"

module Ikalog
  class Engine
    def run
      loop do
        read_next_frame
      end
    end

    private

    # @todo
    # @return [Ikalog::CaptureSource]
    def capture_source
      @capture_source ||= Ikalog::CaptureSource.new
    end

    # @todo
    def read_next_frame
      frame = capture_source.read_frame
      puts frame
      sleep 1
    end
  end
end
