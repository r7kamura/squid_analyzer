require "ikalog/frame"

module Ikalog
  class CaptureSource
    # @todo
    # @return [Ikalog::Frame]
    def read_frame
      Ikalog::Frame.new
    end
  end
end
