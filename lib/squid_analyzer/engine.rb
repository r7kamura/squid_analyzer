require "squid_analyzer/capture_source"
require "squid_analyzer/scene_detector"
require "squid_analyzer/scenes/game_result"

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
          mask_path: "images/game_result_mask.png",
          scene_class: ::SquidAnalyzer::Scenes::GameResult,
          score_threshold: 0.997,
        ),
      ]
    end
  end
end
