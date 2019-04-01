# frozen_string_literal: true

class Rotation < ApplicationRecord
  validates :start, :end, presence: true
  validates_presence_of :name, allow_blank: false
end
