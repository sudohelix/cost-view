# frozen_string_literal: true

class Spots::QueueBatchCreateJob < BaseInteractor
  def call
    BatchCreateJob.perform_later(context.attributes, context.klass)
  end
end
