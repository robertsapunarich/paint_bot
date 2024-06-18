# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Movements', type: :request do
  describe 'POST /movements' do
    it 'returns a valid sequence of coordinates based on the sequence of directions given' do
      params = {
        starting_position: { x: 0, y: 0 },
        directions_sequence: %w[right down right down]
      }

      post('/movements', params:)

      expected = {
        'coordinates_sequence' => [{ 'x' => 0, 'y' => 0 }, { 'x' => 1, 'y' => 0 }, { 'x' => 1, 'y' => 1 },
                                   { 'x' => 2, 'y' => 1 }, { 'x' => 2, 'y' => 2 }],
        'spaces_moved' => 4,
        'final_coordinate' => { 'x' => 2, 'y' => 2 }
      }.to_json
      expect(response.body).to eq(expected)
    end

    it 'creates a movement record that stores both the directions given and the sequence of coordinates returned' do
      params = {
        starting_position: { x: 0, y: 0 },
        directions_sequence: %w[right down right down]
      }

      post('/movements', params:)

      expect(Sequence.last).to be
      expect(Sequence.last.directions_sequence).to eq(%w[right down right down])
      expect(Sequence.last.coordinates_sequence).to eq([{ 'x' => 0, 'y' => 0 }, { 'x' => 1, 'y' => 0 },
                                                        { 'x' => 1, 'y' => 1 }, { 'x' => 2, 'y' => 1 },
                                                        { 'x' => 2, 'y' => 2 }])
      expect(Sequence.last.valid?).to be true
    end

    it 'returns a 400 error with appropriate message if an invalid directions_sequence is given' do
      out_of_bounds_params = {
        starting_position: { x: 0, y: 0 },
        directions_sequence: %w[right down right down down down down down down down down
                                down]
      }

      diagonal_params = {
        starting_position: { x: 0, y: 0 },
        directions_sequence: ['down_and_to_the_right']
      }

      post '/movements', params: out_of_bounds_params
      expect(response).to have_http_status(400)
      expect(JSON.parse(response.body)['message']).to eq('Coordinates out of bounds')

      post '/movements', params: diagonal_params
      expect(response).to have_http_status(400)
      expect(JSON.parse(response.body)['message']).to eq('You must provide a valid direction: right, left, down, or up')
    end
  end
end
