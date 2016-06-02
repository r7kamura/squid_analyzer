require "json"
require "squid_analyzer/capture_source"
require "squid_analyzer/scene_detector"
require "squid_analyzer/scenes/game_result"

module SquidAnalyzer
  class Engine
    def run
      loop do
        step
      end
    end

    private

    # @todo
    # @return [SquidAnalyzer::CaptureSource]
    def capture_source
      @capture_source ||= CaptureSource.new
    end

    # @param image [OpenCV::IplImage]
    # @return [SquidAnalyzer::Scene, nil]
    def detect_scene(image)
      scene_detectors.find do |scene_detector|
        if (scene = scene_detector.call(image))
          break scene
        end
      end
    end

    # @return [Array<SquidAnalyzer::SceneDetector>]
    def scene_detectors
      @scene_detectors ||= [
        ::SquidAnalyzer::SceneDetector.new(
          scene_class: ::SquidAnalyzer::Scenes::GameResult,
          score_threshold: 0.85,
          template_image_path: "images/game_result_win.png",
        ),
      ]
    end

    # @todo
    def step
      if (scene = detect_scene(capture_source.read_image))
        puts JSON.pretty_generate(scene.as_json)
      end
      sleep 1
    end
  end
end
