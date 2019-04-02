# frozen_string_literal: true

require "test_helper"

class RotationTest < ActiveSupport::TestCase
  should validate_presence_of :start
  should validate_presence_of :end
  should validate_presence_of :name

  def setup
    @spots = [
      @first = Spot.new(runs_at: "01/02/2016 8:30 AM", creative: "TEST001H", spend_cents: 12_050, views: 100),
      @second = Spot.new(runs_at: "01/02/2016 11:30 AM", creative: "TEST001H", spend_cents: 24_050, views: 110),
      @third = Spot.new(runs_at: "01/02/2016 3:30 PM", creative: "TEST002H", spend_cents: 50_000, views: 80),
      @fourth = Spot.new(runs_at: "01/02/2016 3:34 PM", creative: "TEST002H", spend_cents: 40_000, views: 90),
      @fifth = Spot.new(runs_at: "01/02/2016 3:40 PM", creative: "TEST001H", spend_cents: 40_000, views: 110),
      @sixth = Spot.new(runs_at: "02/02/2016 7:30 AM", creative: "TEST001H", spend_cents: 70_000, views: 200),
      @seventh = Spot.new(runs_at: "02/02/2016 7:30 PM", creative: "TEST002H", spend_cents: 70_000, views: 300)
    ]
  end

  test "#spots_during returns all spots during a rotation" do
    @spots.each(&:save)
    rotation = Rotation.create!(name: "Test Rotation", start: "7:00 AM", end: "1:00 PM")

    assert_includes rotation.spots_during, @first, "missing first"
    assert_includes rotation.spots_during, @second, "missing second"
    assert_includes rotation.spots_during, @sixth, "missing sixth"
  end

  test "#spots_during excludes spots not in a rotation" do
    @spots.each(&:save)
    rotation = Rotation.create!(name: "Test Rotation", start: "7.00AM", end: "1:00 PM")

    assert_not_includes rotation.spots_during, @third, "missing third"
    assert_not_includes rotation.spots_during, @fourth, "missing fourth"
    assert_not_includes rotation.spots_during, @fifth, "missing fifth"
    assert_not_includes rotation.spots_during, @seventh, "has seventh"
  end
end
