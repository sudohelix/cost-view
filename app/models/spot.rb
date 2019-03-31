# frozen_string_literal: true

class Spot < ApplicationRecord
  monetize :spend_cents

  validates :creative, presence: true
end
