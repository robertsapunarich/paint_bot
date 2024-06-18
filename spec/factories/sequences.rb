# frozen_string_literal: true

FactoryBot.define do
  factory :sequence do
    directions_sequence { %w[right down right down] }
    coordinates_sequence do
      [{ 'x' => 0, 'y' => 0 }, { 'x' => 1, 'y' => 0 }, { 'x' => 1, 'y' => 1 }, { 'x' => 2, 'y' => 1 },
       { 'x' => 2, 'y' => 2 }]
    end
    spaces_moved { 4 }
    final_coordinate { { 'x' => 2, 'y' => 2 } }
  end
end
