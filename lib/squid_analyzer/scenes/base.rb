module SquidAnalyzer
  module Scenes
    class Base
      # @param image [OpenCV::IplImage]
      def initialize(image)
        @image = image
      end
    end
  end
end
