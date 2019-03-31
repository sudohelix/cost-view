# frozen_string_literal: true

class Spots::BatchCreateSpotsFlow < BaseOrganizer
  organize Spots::ParseCsv,
           Spots::QueueBatchCreateJob
end
