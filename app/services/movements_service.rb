# frozen_string_literal: true

class MovementsService
  attr_accessor :starting_position, :directions_sequence, :coordinates_sequence, :spaces_moved, :final_coordinate, :errors, :x, :y

  GRID_SIZE = 10

  def initialize(starting_position, directions_sequence)
    @starting_position = starting_position
    @directions_sequence = directions_sequence
    @coordinates_sequence = []
    @spaces_moved = 0
    @final_coordinate = {}
    @errors = []
    @x = starting_position[:x]
    @y = starting_position[:y]
  end

  def run!
    set_starting_coordinates_in_sequence!
    move_cursor!
    set_final_coordinate!
    create_sequence!
  rescue StandardError => e
    errors << e.message
  end

  private

  def set_starting_coordinates_in_sequence!
    sequence_coordinates!(x, y)
  end
  
  def set_final_coordinate!
    final_coordinate[:x] = coordinates_sequence.last[:x]
    final_coordinate[:y] = coordinates_sequence.last[:y]
  end

  def move_cursor!
    directions_sequence.each do |direction|
      case direction
      when 'right'
        @x += 1
      when 'left'
        @x -= 1
      when 'up'
        @y -= 1
      when 'down'
        @y += 1
      else
        raise 'You must provide a valid direction: right, left, down, or up'
      end

      raise 'Coordinates out of bounds' if x.negative? || x > GRID_SIZE - 1 || y.negative? || y > GRID_SIZE - 1

      sequence_coordinates!(x, y)
      @spaces_moved += 1
    end
  end

  def sequence_coordinates!(x, y)
    coordinates_sequence << { x:, y: }
  end

  def create_sequence!
    Sequence.create!(
      directions_sequence:,
      coordinates_sequence:,
      spaces_moved:,
      final_coordinate:
    )
  end
end
