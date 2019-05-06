# frozen_string_literal: true

class Reports::RotationReportsController < ApplicationController
  def cpv_per_day
    @report = RotationCpvPerDayReportView.new
  end
end
