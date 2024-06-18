# frozen_string_literal: true

class MovementsService
  attr_reader :starting_position, :directions_sequence, :coordinates_sequence, :spaces_moved, :final_coordinate, :errors

  GRID_SIZE = 10

  def initialize(starting_position, directions_sequence)
    @starting_position = starting_position
    @directions_sequence = directions_sequence
    @coordinates_sequence = []
    @spaces_moved = 0
    @final_coordinate = {}
    @errors = []
  end

  def run!
    x = starting_position[:x]
    y = starting_position[:y]

    coordinates_sequence << { x:, y: }
    directions_sequence.each do |direction|
      case direction
      when 'right'
        x += 1
      when 'left'
        x -= 1
      when 'up'
        y -= 1
      when 'down'
        y += 1
      else
        raise 'You must provide a valid direction: right, left, down, or up'
      end

      raise 'Coordinates out of bounds' if x.negative? || x > GRID_SIZE - 1 || y.negative? || y > GRID_SIZE - 1

      coordinates_sequence << { x:, y: }
      @spaces_moved += 1
    end

    final_coordinate[:x] = x
    final_coordinate[:y] = y

    create_sequence!
  rescue StandardError => e
    errors << e.message
  end

  private

  def create_sequence!
    Sequence.create!(
      directions_sequence:,
      coordinates_sequence:,
      spaces_moved:,
      final_coordinate:
    )
  end
end
