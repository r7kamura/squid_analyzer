module Ikalog
  module Scenes
    class Base
      class << self
        # @param frame [Ikalog::Frame]
        def create_instance_if_matched(frame)
          if match(frame)
            new(frame)
          end
        end

        private

        # @param frame [Ikalog::Frame]
        # @return [false, true]
        def match(frame)
          raise ::NotImplementedError
        end
      end

      # @param frame [Ikalog::Frame]
      def initialize(frame)
        @frame = frame
      end
    end
  end
end
