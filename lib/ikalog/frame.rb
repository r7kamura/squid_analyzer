module Ikalog
  class Frame
    attr_reader :ipl_image

    # @param ipl_image [OpenCV::IplImage]
    def initialize(ipl_image)
      @ipl_image = ipl_image
    end

    # @return [OpenCV::IplImage]
    def hsv_image
      @hsv_image ||= @ipl_image.BGR2HSV
    end
  end
end
