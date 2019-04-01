# frozen_string_literal: true

class CreateRotations < ActiveRecord::Migration[5.2]
  def change
    create_table :rotations do |t|
      t.time :start
      t.time :end
      t.string :name

      t.timestamps
    end
  end
end
