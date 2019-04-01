# frozen_string_literal: true

class Rotation < ApplicationRecord
  validates :start, :end, presence: true
  validates :name, presence: { allow_blank: false }
end
