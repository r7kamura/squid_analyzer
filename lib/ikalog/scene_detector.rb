module Ikalog
  class SceneDetector
    # @param options [Hash{Symbol => Object}]
    def initialize(options)
      @options = options
    end

    # @param frame [Ikalog::Frame]
    # @return [Ikalog::Scenes::Base, nil]
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

      # @return [Ikalog::Scenes::Base, nil]
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

      # @return [false, true]
      def has_valid_background?
        background_score > @background_threshold
      end

      # @return [false, true]
      def has_valid_foreground?
        foreground_score > @foreground_threshold
      end
    end
  end
end
