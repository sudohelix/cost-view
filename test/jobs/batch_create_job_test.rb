# frozen_string_literal: true

require "test_helper"

class BatchCreateJobTest < ActiveJob::TestCase
  test "should create no objects with no attributes" do
    assert_no_difference -> { Rotation.count } do
      BatchCreateJob.perform_now([], "Rotation")
    end
  end

  test "should create no objects with nil" do
    assert_no_difference -> { Rotation.count } do
      BatchCreateJob.perform_now(nil, "Rotation")
    end
  end

  test "should create multiple objects with an array of attributes" do
    attrs = [
      { start: "6:00 AM", end: "12:00 PM", name: "Morning" },
      { start: "12:00 PM", end: "4:00 PM", name: "Afternoon" },
      { start: "3:00 PM", end: "8:00 PM", name: "Prime" }
    ]
    assert_difference -> { Rotation.count }, 3 do
      BatchCreateJob.perform_now(attrs, "Rotation")
    end
  end

  test "should create a single object with an array of attributes" do
    attrs = [{ start: "6:00 AM", end: "12:00 PM", name: "Morning" }]
    assert_difference -> { Rotation.count }, 1 do
      BatchCreateJob.perform_now(attrs, "Rotation")
    end
  end

  test "should create a single object with a hash of attributes" do
    attrs = { start: "6:00 AM", end: "12:00 PM", name: "Morning" }
    assert_difference -> { Rotation.count }, 1 do
      BatchCreateJob.perform_now(attrs, "Rotation")
    end
  end
end
