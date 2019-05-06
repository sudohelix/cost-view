# frozen_string_literal: true

class CreateSpots < ActiveRecord::Migration[5.2]
  def change
    create_table :spots do |t|
      t.datetime :runs_at, null: false
      t.string :creative, null: false
      t.integer :spend_cents, default: 0, null: false
      t.integer :views, default: 0, null: false

      t.timestamps
    end
  end
end
