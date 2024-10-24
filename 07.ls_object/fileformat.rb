#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'filedetails'

class FileFormat
  def initialize(files)
    @files = files
    @file_details = @files.map { |file| FileDetails.new(file) }
  end

  def format_files
    @files.each do |file|
      details = FileDetails.new(file)
      formatter(details)
    end
  end

  def formatter(details)
    puts "#{details.filetype}#{details.permission} #{details.hard_link.rjust(max_length[:link])} #{details.owner_name.rjust(max_length[:owner])}  #{details.group_name.rjust(max_length[:group])}  #{details.bite_size.rjust(max_length[:size])} #{details.update_time} #{details.filename}"
  end

  def max_length
    hard_links = @file_details.map(&:hard_link)
    owners = @file_details.map(&:owner_name)
    groups = @file_details.map(&:group_name)
    sizes = @file_details.map(&:bite_size)

    {
      link: hard_links.max_by(&:length).length,
      owner: owners.max_by(&:length).length,
      group: groups.max_by(&:length).length,
      size: sizes.max_by(&:length).length
    }
  end
end
