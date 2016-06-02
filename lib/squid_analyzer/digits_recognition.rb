module SquidAnalyzer
  class DigitsRecognition
    # @param image [OpenCV::IplImage]
    def initialize(image)
      @image = image
    end

    # @return [String]
    def call
      characters.join
    end

    private

    # @return [Array<OpenCV::IplImage>]
    def character_images
      CharacterImagesHorizontalSeparation.new(@image).call
    end

    # @return [Array<String>]
    def characters
      character_images.map do |image|
        DigitRecognition.new(image).call
      end
    end
  end
end
