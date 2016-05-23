require "ikalog/frame"
require "opencv"

module Ikalog
  class CaptureSource
    # @param device_id [Fixnum, String, Symbol, nil]
    # @raise [OpenCV::CvError, StandardError]
    def initialize(device_id = nil)
      @device_id = device_id
      open_cv_capture
    end

    # @return [Ikalog::Frame]
    def read_frame
      Frame.new(@cv_capture.query)
    end

    private

    # @raise [OpenCV::CvError, StandardError]
    def open_cv_capture
      @cv_capture = ::OpenCV::CvCapture.open(@device_id)
    end
  end
end
