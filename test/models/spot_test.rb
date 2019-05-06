# frozen_string_literal: true

require "test_helper"

class SpotTest < ActiveSupport::TestCase
  should validate_presence_of(:creative)
  should validate_presence_of(:views)
  should validate_presence_of(:runs_at)
  should validate_numericality_of(:spend_cents).is_greater_than_or_equal_to(0)
  should validate_numericality_of(:views).is_greater_than_or_equal_to(0)

  test "::csv_row_transform should return a proc" do
    assert_equal "Proc", Spot.csv_row_transform.class.to_s
  end

  test "::csv_row_transform should transform 'date' and 'time' keys to 'runs_at'" do
    func = Spot.csv_row_transform
    row = { date: "01/02/2016", time: "9:00 AM" }

    result = func.call(row)

    assert_not result.key?(:date)
    assert_not result.key?(:time)
    assert result.key?(:runs_at)
    assert result[:runs_at].class == String
    assert_equal DateTime.strptime("#{row[:date]} #{row[:time]}", "%d/%m/%Y %k:%M %p").to_s, result[:runs_at]
  end

  test "::csv_row_transform proc requires 'time' key" do
    func = Spot.csv_row_transform
    row = { date: "01/02/2016" }

    assert_raises ArgumentError do
      func.call(row)
    end
  end

  test "::csv_row_transform proc requires 'date' key" do
    func = Spot.csv_row_transform
    row = { time: "09:15 PM" }

    assert_raises ArgumentError do
      func.call(row)
    end
  end

  test "#cpv should return the Float::INFINITY if there are no views" do
    @spot = spots(:zero_views)
    assert_equal Float::INFINITY, @spot.cpv
  end

  test "#cpv should return the cost / view - cost per view - for non-zero views" do
    @spot = Spot.new(spend_cents: 10_000, views: 10)
    assert_equal 10.0, @spot.cpv.to_f
  end
end
