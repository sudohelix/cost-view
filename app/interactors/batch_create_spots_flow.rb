# frozen_string_literal: true

class BatchCreateSpotsFlow < BaseOrganizer
  organize ParseCsv,
           QueueBatchCreateJob
end
