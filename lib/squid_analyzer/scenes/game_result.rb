module SquidAnalyzer
  module Scenes
    class GameResult < Base
      DEATHS_COUNT_HEIGHT = 21
      DEATHS_COUNT_LEFT_IN_PLAYER_RECORD = 575
      DEATHS_COUNT_WIDTH = 31
      KILLS_COUNT_HEIGHT = DEATHS_COUNT_HEIGHT
      KILLS_COUNT_LEFT_IN_PLAYER_RECORD = DEATHS_COUNT_LEFT_IN_PLAYER_RECORD
      KILLS_COUNT_WIDTH = DEATHS_COUNT_WIDTH
      LEVEL_WIDTH = 43
      LOSE_PLAYER_RECORD_TOP = 431
      PLAYER_RECORD_HEIGHT = 65
      PLAYER_RECORD_INNER_HEIGHT = 45
      PLAYER_RECORD_LEFT = 610
      PLAYER_RECORD_WIDTH = 610
      RECORDS_COUNT_PER_TEAM = 4
      WIN_PLAYER_RECORD_TOP = 101

      # @return [Hash]
      def as_json
        {
          lose_players: lose_players,
          type: self.class.to_s.split("::").last,
          win_players: win_players,
        }
      end

      private

      # @todo
      # @param position [Hash{Symbol => Integer}]
      # @return [Hash{Symbol => Hash}]
      def analyze_player_record(position)
        {
          deaths_count: recognize_digits(
            height: DEATHS_COUNT_HEIGHT,
            left: position[:left] + DEATHS_COUNT_LEFT_IN_PLAYER_RECORD,
            top: position[:top] + DEATHS_COUNT_HEIGHT,
            width: DEATHS_COUNT_WIDTH,
          ),
          is_my_record: recognize_is_my_record(
            height: PLAYER_RECORD_HEIGHT,
            left: position[:left],
            top: position[:top],
            width: LEVEL_WIDTH,
          ),
          kills_count: recognize_digits(
            height: KILLS_COUNT_HEIGHT,
            left: position[:left] + KILLS_COUNT_LEFT_IN_PLAYER_RECORD,
            top: position[:top],
            width: KILLS_COUNT_WIDTH,
          ),
        }
      end

      # @return [Array<Hash>]
      def lose_player_record_positions
        RECORDS_COUNT_PER_TEAM.times.map do |i|
          {
            left: PLAYER_RECORD_LEFT,
            top: LOSE_PLAYER_RECORD_TOP + i * PLAYER_RECORD_HEIGHT,
          }
        end
      end

      # @return [Array<Hash>]
      def lose_players
        lose_player_record_positions.map do |lose_player_record_position|
          analyze_player_record(lose_player_record_position)
        end
      end

      # @param height [Integer]
      # @param left [Integer]
      # @param top [Integer]
      # @param width [Integer]
      # @return [Integer]
      def recognize_digits(height:, left:, top:, width:)
        image = @image.clone
        image.roi = ::OpenCV::CvRect.new(left, top, width, height)
        DigitsRecognition.new(image).call.to_i
      end

      # @param height [Integer]
      # @param left [Integer]
      # @param top [Integer]
      # @param width [Integer]
      # @return [false, true]
      def recognize_is_my_record(height:, left:, top:, width:)
        image = @image.clone
        image.roi = ::OpenCV::CvRect.new(left, top, width, height)
        image.BGR2GRAY.threshold(230, 255, ::OpenCV::CV_THRESH_BINARY).count_non_zero.to_f / (image.roi.width * image.roi.height) > 0.1
      end

      # @return [Array<Hash>]
      def win_player_record_positions
        RECORDS_COUNT_PER_TEAM.times.map do |i|
          {
            left: PLAYER_RECORD_LEFT,
            top: WIN_PLAYER_RECORD_TOP + i * PLAYER_RECORD_HEIGHT,
          }
        end
      end

      # @return [Array<Hash>]
      def win_players
        win_player_record_positions.map do |win_player_record_position|
          analyze_player_record(win_player_record_position)
        end
      end
    end
  end
end
