require "ikalog/scenes/base"

module Ikalog
  module Scenes
    class Lobby < Base
      class << self
        private

        # @todo
        # @note Override
        def match(frame)
          true
        end
      end
    end
  end
end
