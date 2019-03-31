# frozen_string_literal: true

class Spot < ApplicationRecord
  monetize :spend_cents

  validates :creative, presence: true

  def self.csv_row_transform
    proc do |row|
      raw_attrs = row.to_h.transform_keys!(&:downcase).with_indifferent_access
      raw_attrs[:runs_at] = DateTime.strptime("#{raw_attrs[:date]} #{raw_attrs[:time]}", "%d/%m/%Y %k:%M %p").to_s

      raw_attrs.except(:date, :time)
    end
  end

  def cpv
    return 0 if views.zero?
    spend / views
  end
end
