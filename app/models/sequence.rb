# frozen_string_literal: true

class Sequence < ApplicationRecord
  validates :directions_sequence, presence: true
  validates :coordinates_sequence, presence: true
  validates :spaces_moved, presence: true
  validates :final_coordinate, presence: true
end
