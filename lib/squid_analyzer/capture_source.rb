module SquidAnalyzer
  class CaptureSource
    # @param device_id [Fixnum, String, Symbol, nil]
    # @raise [OpenCV::CvError, StandardError]
    def initialize(device_id = nil)
      @device_id = device_id
      open_cv_capture
    end

    # @return [::OpenCV::IplImage]
    def read_image
      @cv_capture.query
    end

    private

    # @raise [OpenCV::CvError, StandardError]
    def open_cv_capture
      blink_cv_capture_for_device_to_be_recognized
      @cv_capture = ::OpenCV::CvCapture.open(@device_id)
    end

    # @note Some devices cannot be recognized at the 1st time.
    def blink_cv_capture_for_device_to_be_recognized
      ::OpenCV::CvCapture.open.close
    end
  end
end
