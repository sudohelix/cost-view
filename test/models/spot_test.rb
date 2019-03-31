# frozen_string_literal: true

require "test_helper"

class SpotTest < ActiveSupport::TestCase
  should validate_presence_of(:creative)
end
