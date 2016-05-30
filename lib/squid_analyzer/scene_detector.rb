module SquidAnalyzer
  class SceneDetector
    # @param options [Hash{Symbol => Object}]
    def initialize(options)
      @options = options
    end

    # @param frame [SquidAnalyzer::Frame]
    # @return [SquidAnalyzer::Scenes::Base, nil]
    def call(frame)
      keyword_arguments = @options.merge(frame: frame)
      Detection.new(**keyword_arguments).call
    end

    class Detection
      def initialize(
        frame:,
        scene_class:,
        score_threshold:,
        template_image_path:
      )
        @frame = frame
        @scene_class = scene_class
        @score_threshold = score_threshold
        @template_image_path = template_image_path
      end

      # @return [SquidAnalyzer::Scenes::Base, nil]
      def call
        if matched?
          @scene_class.new
        end
      end

      private

      # @return [false, true]
      def matched?
        score >= @score_threshold
      end

      # @return [Float]
      def score
        @frame.ipl_image.match_template(template_image, ::OpenCV::CV_TM_CCORR_NORMED).min_max_loc[1]
      end

      # @return [OpenCV::IplImage]
      def template_image
        ::OpenCV::IplImage.load(@template_image_path)
      end
    end
  end
end
