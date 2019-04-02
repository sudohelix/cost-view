# frozen_string_literal: true

class RotationCpvPerDayReportView
  attr_accessor :rotations

  def initialize(rotations = Rotation.by_start_time.all)
    @rotations = rotations
  end

  def spend_by_date
    @spend_by_date ||= rotations.map do |r|
      {
        name: r.name,
        start: r.start,
        end: r.end,
        spend_by_date: r.spots_during.group_by(&:date).map do |k, v|
          {
            date: k,
            total_spend: v.sum(&:spend),
            total_views: v.sum(&:views),
            total_cpv: v.sum(&:cpv)
          }
        end
      }
    end
  end
end
