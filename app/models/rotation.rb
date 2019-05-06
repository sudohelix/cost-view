# frozen_string_literal: true

class Rotation < ApplicationRecord
  TIME_FORMAT = "%k:%M" # "ie. 23:45"

  validates :start, :end, presence: true
  validates :name, presence: { allow_blank: false }

  scope :by_start_time, -> { order(start: :asc) }

  def spots_during
    start_time, end_time = [start, self.end].map(&method(:spot_time_format))

    Spot.select("*, DATE(runs_at) as date, TIME(runs_at) as spot_time")
        .where("spot_time >= :start_time and spot_time < :end_time",
               start_time: start_time,
               end_time: end_time)
        .order("creative, date ASC")
  end

  private

  def spot_time_format(date)
    date.strftime(TIME_FORMAT)
  end
end
