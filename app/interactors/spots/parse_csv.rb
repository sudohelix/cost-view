# frozen_string_literal: true

require 'csv'

class Spots::ParseCsv < BaseInteractor
  attr_accessor :date, :time

  def call
    attributes = []
    CSV.foreach(csv_file, headers: true, force_quotes: true, skip_blanks: true) do |row|
      attributes << transform_row.call(row)
    end

    context.attributes = attributes
  end

  def csv_file
    @csv_file ||= context.csv_file.tempfile
  end

  def transform_row
    @transform_rows_proc ||= context.transform.presence || :itself.to_proc
  end
end
