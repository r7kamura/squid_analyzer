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
        mask_path:,
        scene_class:,
        score_threshold:
      )
        @frame = frame
        @mask_path = mask_path
        @scene_class = scene_class
        @score_threshold = score_threshold
      end

      # @return [SquidAnalyzer::Scenes::Base, nil]
      def call
        if matched?
          @scene_class.new
        end
      end

      private

      # @return [OpenCV::IplImage]
      def binary_image_with_black_area
        @frame.ipl_image.BGR2GRAY.threshold(230, 255, OpenCV::CV_THRESH_BINARY)
      end

      # @return [Integer]
      def image_elements_count
        @frame.ipl_image.width * @frame.ipl_image.height
      end

      # @return [Integer]
      def left_elements_count_after_masked
        image_elements_count - binary_image_with_black_area.add(mask_image).count_non_zero
      end

      # @return [OpenCV::IplImage]
      def mask_image
        ::OpenCV::IplImage.load(@mask_path, ::OpenCV::CV_LOAD_IMAGE_GRAYSCALE)
      end

      # @return [false, true]
      def matched?
        score > @score_threshold
      end

      # @return [Float]
      def score
        1 - (left_elements_count_after_masked.to_f / image_elements_count)
      end
    end
  end
end
