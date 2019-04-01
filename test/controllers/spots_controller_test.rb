# frozen_string_literal: true

require "test_helper"

class SpotsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @spot = spots(:one)
  end

  test "should get index" do
    get spots_url
    assert_response :success
  end

  test "should get new" do
    get new_spot_url
    assert_response :success
  end

  test "should create spot" do
    assert_difference("Spot.count") do
      post spots_url, params: { spot: {
        creative: @spot.creative,
        runs_at: @spot.runs_at,
        spend_cents: @spot.spend, views: @spot.views
      } }
    end

    assert_redirected_to spot_url(Spot.last)
  end

  test "should show spot" do
    get spot_url(@spot)
    assert_response :success
  end

  test "should get edit" do
    get edit_spot_url(@spot)
    assert_response :success
  end

  test "should update spot" do
    patch spot_url(@spot), params: { spot: {
      creative: @spot.creative,
      runs_at: @spot.runs_at,
      spend_cents: @spot.spend,
      views: @spot.views
    } }
    assert_redirected_to spot_url(@spot)
  end

  test "should destroy spot" do
    assert_difference("Spot.count", -1) do
      delete spot_url(@spot)
    end

    assert_redirected_to spots_url
  end

  test "should get upload" do
    get upload_spots_url
    assert_response :success
  end

  test "should batch_create spots" do
    bulk_spots = fixture_file_upload("/files/spots.csv", "text/csv")

    assert_difference -> { Spot.count }, 7 do
      post batch_create_spots_url, params: { batch: { csv_file: bulk_spots } }
    end
    assert_redirected_to spots_path
    assert_equal"Batch upload started successfully.", flash[:notice]
  end
end
