module Ikalog
  class Frame
    # @param ipl_image [OpenCV::IplImage]
    def initialize(ipl_image)
      @ipl_image = ipl_image
    end

    # @note Override to ease debugging
    def to_s
      "#<#{self.class}::#{object_id} height=#{@ipl_image.height} width=#{@ipl_image.width}>"
    end
  end
end
