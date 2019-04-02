# frozen_string_literal: true

require 'test_helper'

class RotationCpvPerDayReportViewTest < ActiveSupport::TestCase
  def setup
    @spots = [
        @first = Spot.create!(runs_at: "01/02/2016 8:30 AM", creative: "TEST001H", spend_cents: 12050, views: 100),
        @second = Spot.create!(runs_at: "01/02/2016 11:30 AM", creative: "TEST001H", spend_cents: 24050, views: 110),
        @third = Spot.create!(runs_at: "01/02/2016 3:30 PM", creative: "TEST002H", spend_cents: 50000, views: 80),
        @fourth = Spot.create!(runs_at: "01/02/2016 3:34 PM", creative: "TEST002H", spend_cents: 40000, views: 90),
        @fifth = Spot.create!(runs_at: "01/02/2016 3:40 PM", creative: "TEST001H", spend_cents: 40000, views: 110),
        @sixth = Spot.create!(runs_at: "02/02/2016 7:30 AM", creative: "TEST001H", spend_cents: 70000, views: 200),
        @seventh = Spot.create!(runs_at: "02/02/2016 7:30 PM", creative: "TEST002H", spend_cents: 70000, views: 300),
    ]
    @rotation = Rotation.create!(name: "Rotation 1", start: "7:00 AM", end: "1:00 PM")
    @rotation2 = Rotation.create!(name: "Rotation 2", start: "2:00 PM", end: "8:00 PM")
    @rotation_names = [@rotation, @rotation2].map(&:name)
    @day1 = "2016-02-01"
    @day2 = "2016-02-02"

    @report = RotationCpvPerDayReportView.new.spend_by_date
  end

  test "rotation 1 first day" do
    report = @report.find { |s| s[:name] == "Rotation 1" }

    rot1_first_day = report[:spend_by_date].find { |r| r[:date] == @day1 }
    assert_equal 210, rot1_first_day[:total_views]
    assert_equal Money.new(12050 + 24050), rot1_first_day[:total_spend]
    assert_equal @first.cpv + @second.cpv, rot1_first_day[:total_cpv]
  end

  test "rotation 1 second day" do
    report = @report.find { |s| s[:name] == "Rotation 1" }
    assert report

    rot1_second_day = report[:spend_by_date].find { |r| r[:date] == @day2 }
    assert_equal 200, rot1_second_day[:total_views]
    assert_equal Money.new(70000), rot1_second_day[:total_spend]
    assert_equal @sixth.cpv, rot1_second_day[:total_cpv]
  end

  test "rotation 2 first day" do
    report = @report.find { |s| s[:name] == "Rotation 2" }
    assert report

    rot2_first_day = report[:spend_by_date].find { |r| r[:date] == @day1 }
    assert_equal 280, rot2_first_day[:total_views]
    assert_equal Money.new(50000 + + 40000 + 40000), rot2_first_day[:total_spend]
    assert_equal @third.cpv + @fourth.cpv + @fifth.cpv, rot2_first_day[:total_cpv]
  end

  test "rotation 2 second day" do
    report = @report.find { |s| s[:name] == "Rotation 2" }
    assert report

    rot2_second_day = report[:spend_by_date].find { |r| r[:date] == @day2 }
    assert_equal 300, rot2_second_day[:total_views]
    assert_equal Money.new(70000), rot2_second_day[:total_spend]
    assert_equal @seventh.cpv, rot2_second_day[:total_cpv]
  end
end
