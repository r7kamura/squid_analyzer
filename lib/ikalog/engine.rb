require "ikalog/capture_source"
require "ikalog/scene_detector"
require "ikalog/scenes/lobby"

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

    # @param frame [Ikalog::Frame]
    # @return [Ikalog::Scene, nil]
    def detect_scene(frame)
      scene_detectors.find do |scene_detector|
        if (scene = scene_detector.call(frame.clone))
          break scene
        end
      end
    end

    # @todo
    def read_next_frame
      scene = detect_scene(capture_source.read_frame)
      puts scene
      sleep 1
    end

    # @return [Array<Ikalog::SceneDetector>]
    def scene_detectors
      @scene_detectors ||= [
        ::Ikalog::SceneDetector.new(
          background_method: "TODO",
          background_threshold: 0.100,
          foreground_method: "TODO",
          foreground_threshold: 0.9,
          height: 90,
          label: "downie/slot_window",
          left: 430,
          mask_image_file_name: "downie_lottery.png",
          scene_class: ::Ikalog::Scenes::Lobby,
          top: 165,
          width: 640,
        ),
      ]
    end
  end
end
