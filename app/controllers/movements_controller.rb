# frozen_string_literal: true

class MovementsController < ApplicationController
  def create
    starting_position = movement_params[:starting_position].to_h.map { |k, v| [k.to_sym, v.to_i] }.to_h
    directions_sequence = movement_params[:directions_sequence]
    service = MovementsService.new(starting_position, directions_sequence)
    service.run!

    if service.errors.any?
      render json: { message: service.errors.join(', ') }, status: 400
    else
      render json: {
        coordinates_sequence: service.coordinates_sequence,
        spaces_moved: service.spaces_moved,
        final_coordinate: service.final_coordinate
      }, status: 200
    end
  end

  private

  def movement_params
    params.permit(starting_position: %i[x y], directions_sequence: [])
  end
end
