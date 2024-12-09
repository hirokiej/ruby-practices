# frozen_string_literal: true

require_relative 'filedetails'

class LongFileFormatter
  def initialize(files)
    @files = files
    @file_details = @files.map { |file| FileDetails.new(file) }
  end

  def format
    formatted_file_details = []
    formatted_file_details << "total #{total_blocks}"
    @files.each do |file|
      details = FileDetails.new(file)
      formatted_file_details << format_details(details)
    end
    formatted_file_details.join("\n")
  end

  private

  def total_blocks
    @files.sum { |file| File.stat(file).blocks }
  end

  def format_details(details)
    "#{details.filetype}#{details.permission} #{details.hard_link.rjust(max_length[:link])} "\
    "#{details.owner_name.rjust(max_length[:owner])}  #{details.group_name.rjust(max_length[:group])}  "\
    "#{details.bite_size.rjust(max_length[:size])} #{details.update_time.rjust(max_length[:update_time])} "\
    "#{details.filename}"
  end

  def max_length_for(stat_details)
    @file_details.map(&stat_details).max_by(&:length)
  end

  def max_length
    {
      link: max_length_for(:hard_link).length,
      owner: max_length_for(:owner_name).length,
      group: max_length_for(:group_name).length,
      size: max_length_for(:bite_size).length,
      update_time: max_length_for(:update_time).length
    }
  end
end
