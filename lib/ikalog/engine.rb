require "ikalog/capture_source"
require "ikalog/scene_detection"

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
      @capture_source ||= CaptureSource.new
    end

    # @todo
    def read_next_frame
      frame = capture_source.read_frame
      scene = SceneDetection.new(frame).call
      puts scene
      sleep 1
    end
  end
end
