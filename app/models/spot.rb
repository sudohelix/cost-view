# frozen_string_literal: true

class Spot < ApplicationRecord
  monetize :spend_cents

  validates :spend_cents, :views, numericality: { greater_than_or_equal_to: 0 }
  validates :creative, :views, :runs_at, presence: true

  def self.csv_row_transform
    proc do |row|
      raw_attrs = row.dup
      raw_attrs[:runs_at] = DateTime.strptime("#{raw_attrs[:date]} #{raw_attrs[:time]}",
                                              "%d/%m/%Y %k:%M %p").to_s

      raw_attrs.except(:date, :time)
    end
  end

  def cpv
    views.zero? ? spend : spend / views
  end
end
