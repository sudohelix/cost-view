# frozen_string_literal: true

# frozen_string_literal

class Reports::RotationReportsController < ApplicationController
  def cpv_per_day
    @report = RotationCpvPerDayReportView.new
  end
end
