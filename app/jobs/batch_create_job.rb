# frozen_string_literal: true

class BatchCreateJob < ApplicationJob
  queue_as :default

  def perform(attributes_array, klass)
    return if attributes_array.blank?

    ActiveRecord::Base.transaction do
      klass.constantize.create! attributes_array
    end
  end
end
