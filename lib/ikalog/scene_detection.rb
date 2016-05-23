require "ikalog/scenes/lobby"

module Ikalog
  class SceneDetection
    AVAILABLE_SCENE_CLASSES = [
      Scenes::Lobby,
    ]

    # @param frame [Ikalog::Frame]
    def initialize(frame)
      @frame = frame
    end

    # @todo
    # @return [Ikalog::Scenes::Base, nil]
    def call
      AVAILABLE_SCENE_CLASSES.find do |klass|
        klass.create_instance_if_matched(@frame)
      end
    end
  end
end
