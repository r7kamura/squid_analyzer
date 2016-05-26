require "squid_analyzer/capture_source"
require "squid_analyzer/scene_detector"
require "squid_analyzer/scenes/lobby"

module SquidAnalyzer
  class Engine
    def run
      loop do
        read_next_frame
      end
    end

    private

    # @todo
    # @return [SquidAnalyzer::CaptureSource]
    def capture_source
      @capture_source ||= CaptureSource.new
    end

    # @param frame [SquidAnalyzer::Frame]
    # @return [SquidAnalyzer::Scene, nil]
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

    # @return [Array<SquidAnalyzer::SceneDetector>]
    def scene_detectors
      @scene_detectors ||= [
        ::SquidAnalyzer::SceneDetector.new(
          background_method: "TODO",
          background_threshold: 0.100,
          foreground_method: "TODO",
          foreground_threshold: 0.9,
          height: 90,
          label: "lobby",
          left: 0,
          mask_image_file_name: "lobby.png",
          scene_class: ::SquidAnalyzer::Scenes::Lobby,
          top: 0,
          width: 640,
        ),
      ]
    end
  end
end
