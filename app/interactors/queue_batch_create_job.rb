# frozen_string_literal: true

class QueueBatchCreateJob < BaseInteractor
  def call
    BatchCreateJob.perform_later(context.attributes, context.klass)
  end
end
