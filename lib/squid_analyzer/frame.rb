module SquidAnalyzer
  class Frame
    attr_reader :ipl_image

    # @param ipl_image [OpenCV::IplImage]
    def initialize(ipl_image)
      @ipl_image = ipl_image
    end
  end
end
