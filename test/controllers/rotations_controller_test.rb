# frozen_string_literal: true

require "test_helper"

class RotationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @rotation = rotations(:one)
  end

  test "should get index" do
    get rotations_url
    assert_response :success
  end

  test "should get new" do
    get new_rotation_url
    assert_response :success
  end

  test "should create rotation" do
    assert_difference("Rotation.count") do
      post rotations_url, params: { rotation: { end: @rotation.end, name: @rotation.name, start: @rotation.start } }
    end

    assert_redirected_to rotation_url(Rotation.last)
  end

  test "should show rotation" do
    get rotation_url(@rotation)
    assert_response :success
  end

  test "should get edit" do
    get edit_rotation_url(@rotation)
    assert_response :success
  end

  test "should update rotation" do
    patch rotation_url(@rotation), params: { rotation: { end: @rotation.end, name: @rotation.name, start: @rotation.start } }
    assert_redirected_to rotation_url(@rotation)
  end

  test "should destroy rotation" do
    assert_difference("Rotation.count", -1) do
      delete rotation_url(@rotation)
    end

    assert_redirected_to rotations_url
  end

  test "should get upload" do
    get upload_rotations_url
    assert_response :success
  end

  test "should batch_create spots" do
    bulk_rotations = fixture_file_upload("/files/rotations.csv", "text/csv")

    assert_difference -> { Rotation.count }, 3 do
      post batch_create_rotations_url, params: { batch: { csv_file: bulk_rotations } }
    end
    assert_redirected_to rotations_path
    assert_equal "Batch upload started successfully.", flash[:notice]
  end
end
