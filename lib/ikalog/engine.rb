module Ikalog
  class Engine
    def run
      loop do
        read_next_frame
      end
    end

    private

    # @todo
    def read_next_frame
      puts Time.now
      sleep 1
    end
  end
end
