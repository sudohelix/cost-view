# frozen_string_literal: true

require "csv"

class ParseCsv < BaseInteractor
  attr_accessor :date, :time

  def call
    attributes = []
    CSV.foreach(csv_file, headers: true, force_quotes: true, skip_blanks: true) do |row|
      row_hash = row.to_h.transform_keys!(&:downcase).with_indifferent_access
      attributes << transform_row.call(row_hash)
    rescue StandardError
      context.fail! message: "Invalid data in CSV file: #{original_name}"
    end

    context.attributes = attributes
  end

  def csv_file
    @csv_file ||= context.csv_file.tempfile
  end

  def original_name
    @original_name ||= context.csv_file.original_filename
  end

  def transform_row
    @transform_row ||= context.transform.presence || :itself.to_proc
  end
end
