module SquidAnalyzer
  module Scenes
    class Base
      class << self
        # @param frame [SquidAnalyzer::Frame]
        def create_instance_if_matched(frame)
          if match(frame)
            new(frame)
          end
        end

        private

        # @param frame [SquidAnalyzer::Frame]
        # @return [false, true]
        def match(frame)
          raise ::NotImplementedError
        end
      end
    end
  end
end
