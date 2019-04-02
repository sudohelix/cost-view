# frozen_string_literal: true

module ApplicationHelper
  def format_time(datetime, format = "%I:%M %p")
    datetime.strftime(format)
  end

  def format_date(datetime, format = "%d/%m/%Y %I:%M %p")
    format_time(datetime, format)
  end
end
