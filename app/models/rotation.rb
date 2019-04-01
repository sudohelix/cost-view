# frozen_string_literal: true

class Rotation < ApplicationRecord
  validates :start, :end, :name, presence: true
end
