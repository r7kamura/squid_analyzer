require "squid_analyzer/scenes/base"
require "squid_analyzer/digits_recognition"

module SquidAnalyzer
  module Scenes
    class GameResult < Base
      DEATHS_COUNT_HEIGHT = 21
      DEATHS_COUNT_LEFT_IN_PLAYER_ENTRY = 575
      DEATHS_COUNT_WIDTH = 31
      ENTRIES_COUNT_PER_TEAM = 4
      KILLS_COUNT_HEIGHT = DEATHS_COUNT_HEIGHT
      KILLS_COUNT_LEFT_IN_PLAYER_ENTRY = DEATHS_COUNT_LEFT_IN_PLAYER_ENTRY
      KILLS_COUNT_WIDTH = DEATHS_COUNT_WIDTH
      LOSE_PLAYER_ENTRY_TOP = 431
      PLAYER_ENTRY_HEIGHT = 65
      PLAYER_ENTRY_INNER_HEIGHT = 45
      PLAYER_ENTRY_LEFT = 610
      PLAYER_ENTRY_WIDTH = 610
      WIN_PLAYER_ENTRY_TOP = 101

      # @return [Hash]
      def as_json
        {
          lose_players: lose_players,
          win_players: win_players,
        }
      end

      private

      # @todo
      # @param position [Hash{Symbol => Integer}]
      # @return [Hash{Symbol => Hash}]
      def analyze_player_entry(position)
        {
          deaths_count: recognize_digits(
            height: DEATHS_COUNT_HEIGHT,
            left: position[:left] + DEATHS_COUNT_LEFT_IN_PLAYER_ENTRY,
            top: position[:top] + DEATHS_COUNT_HEIGHT,
            width: DEATHS_COUNT_WIDTH,
          ),
          kills_count: recognize_digits(
            height: KILLS_COUNT_HEIGHT,
            left: position[:left] + KILLS_COUNT_LEFT_IN_PLAYER_ENTRY,
            top: position[:top],
            width: KILLS_COUNT_WIDTH,
          ),
        }
      end

      # @return [Array<Hash>]
      def lose_player_entry_positions
        ENTRIES_COUNT_PER_TEAM.times.map do |i|
          {
            left: PLAYER_ENTRY_LEFT,
            top: LOSE_PLAYER_ENTRY_TOP + i * PLAYER_ENTRY_HEIGHT,
          }
        end
      end

      # @return [Array<Hash>]
      def lose_players
        lose_player_entry_positions.map do |lose_player_entry_position|
          analyze_player_entry(lose_player_entry_position)
        end
      end

      # @param height [Integer]
      # @param left [Integer]
      # @param top [Integer]
      # @param width [Integer]
      # @return [Integer]
      def recognize_digits(height:, left:, top:, width:)
        image = @frame.ipl_image.clone
        image.roi = ::OpenCV::CvRect.new(left, top, width, height)
        DigitsRecognition.new(image).call.to_i
      end

      # @return [Array<Hash>]
      def win_player_entry_positions
        ENTRIES_COUNT_PER_TEAM.times.map do |i|
          {
            left: PLAYER_ENTRY_LEFT,
            top: WIN_PLAYER_ENTRY_TOP + i * PLAYER_ENTRY_HEIGHT,
          }
        end
      end

      # @return [Array<Hash>]
      def win_players
        win_player_entry_positions.map do |win_player_entry_position|
          analyze_player_entry(win_player_entry_position)
        end
      end
    end
  end
end
