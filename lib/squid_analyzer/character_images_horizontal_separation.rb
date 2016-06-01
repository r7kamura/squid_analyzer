module SquidAnalyzer
  class CharacterImagesHorizontalSeparation
    # @param image [OpenCV::IplImage]
    def initialize(image)
      @image = image
      @i = 0
      @in_white = false
      @ranges = []
      @start = nil
    end

    # @return [Array<OpenCV::IplImage>]
    def call
      scan
      @ranges.map do |range|
        image = @image.clone
        image.roi = ::OpenCV::CvRect.new(
          image.roi.x + range.first,
          image.roi.y,
          range.last - range.first,
          image.roi.height
        )
        image
      end
    end

    private

    def scan
      white_only_image.each_column do |column|
        if column.sum[0] > 0
          unless @in_white
            @start = @i
            @in_white = true
          end
        else
          if @in_white
            @ranges << (@start..@i)
            @in_white = false
          end
        end
        @i += 1
      end
      if @in_white
        @ranges << (@start..@i)
      end
    end

    # @return [OpenCV::IplImage]
    def white_only_image
      @image.BGR2HSV.in_range(
        ::OpenCV::CvScalar.new(0, 0, 230),
        ::OpenCV::CvScalar.new(180, 32, 255),
      )
    end
  end
end
