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
        background_method:,
        background_threshold:,
        foreground_method:,
        foreground_threshold:,
        frame:,
        height:,
        label:,
        left:,
        mask_image_file_name:,
        scene_class:,
        top:,
        width:
      )
        @background_method = background_method
        @background_threshold = background_threshold
        @foreground_method = foreground_method
        @foreground_threshold = foreground_threshold
        @frame = frame
        @height = height
        @label = label
        @left = left
        @mask_image_file_name = mask_image_file_name
        @scene_class = scene_class
        @top = top
        @width = width
      end

      # @return [SquidAnalyzer::Scenes::Base, nil]
      def call
        if has_valid_background? && has_valid_foreground?
          @scene_class.new
        end
      end

      private

      # @todo
      # @return [Float]
      def background_score
        1.0
      end

      # @todo
      # @return [Float]
      def foreground_score
        1.0
      end

      # @return [OpenCV::CvMat]
      def binary_image_only_black_area
        @frame.ipl_image.BGR2HSV.in_range(
          ::OpenCV::CvScalar.new(0, 0, 0),
          ::OpenCV::CvScalar.new(180, 255, 32),
        ).not
      end

      # @return [OpenCV::CvMat]
      def binary_image_only_white_area
        @frame.ipl_image.BGR2HSV.in_range(
          ::OpenCV::CvScalar.new(0, 0, 230),
          ::OpenCV::CvScalar.new(180, 32, 255),
        ).not
      end

      # @return [false, true]
      def has_valid_background?
        background_score > @background_threshold
      end

      # @return [false, true]
      def has_valid_foreground?
        foreground_score > @foreground_threshold
      end

      # @todo
      # @return [OpenCV::CvHistogram]
      def histogram
        ::OpenCV::CvHistogram.new(
          1,
          [3],
          ::OpenCV::CV_HIST_ARRAY,
          [[0, 255]],
        ).calc_hist([@frame.ipl_image.BGR2GRAY])
      end

      # @return [OpenCV::IplImage]
      def mask_ipl_image
        ::OpenCV::IplImage.load(@mask_image_file_name, ::OpenCV::CV_LOAD_IMAGE_GRAYSCALE)
      end
    end
  end
end
