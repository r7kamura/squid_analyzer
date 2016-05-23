require "ikalog/scene"

module Ikalog
  class SceneDetection
    # @param frame [Ikalog::Frame]
    def initialize(frame)
      @frame = frame
    end

    # @todo
    # @return [Ikalog::Scene]
    def call
      Scene.new
    end
  end
end
