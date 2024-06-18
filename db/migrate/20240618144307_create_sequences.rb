# frozen_string_literal: true

class CreateSequences < ActiveRecord::Migration[7.1]
  def change
    create_table :sequences do |t|
      t.json :directions_sequence, null: false, default: []
      t.json :coordinates_sequence, null: false, default: []
      t.integer :spaces_moved, null: false, default: 0
      t.json :final_coordinate, null: false, default: {}
      t.timestamps
    end
  end
end
