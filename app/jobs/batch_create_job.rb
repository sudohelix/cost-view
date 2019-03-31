class BatchCreateJob < ApplicationJob
  queue_as :default

  def perform(attributes_array, klass)
    ActiveRecord::Base.transaction do
      klass.constantize.create! attributes_array
    end
  end
end
