module SquidAnalyzer
  class VerticalMarginTrimming
    # @param image [OpenCV::IplImage]
    def initialize(image)
      @image = image
      @i = 0
      @in_white = false
      @ranges = []
      @start = nil
    end

    # @return [OpenCV::IplImage]
    def call
      scan
      range = @ranges[0]
      image = @image.clone
      image.roi = ::OpenCV::CvRect.new(
        image.roi.x,
        image.roi.y + range.first,
        image.roi.width,
        range.last - range.first,
      )
      image
    end

    private

    def scan
      white_only_image.each_row do |row|
        if row.sum[0] > 0
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
