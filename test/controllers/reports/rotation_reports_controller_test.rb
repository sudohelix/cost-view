# frozen_string_literal: true

require 'test_helper'

class Reports::RotationReportsControllerText < ActionDispatch::IntegrationTest
  test "should get cpv_per_day" do
    get reports_rotation_reports_cpv_per_day_url
    assert_response :success
  end
end
