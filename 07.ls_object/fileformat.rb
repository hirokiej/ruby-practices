#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'filedetails'

class FileFormat
  def initialize(files)
    @files = files
  end

  def format_files
    @files.each do |file|
      formatter(file)
    end
  end

  def formatter(file)
    details = FileDetails.new(file)
    puts "#{details.filetype}#{details.permission} #{details.hard_link} #{details.owner_name} #{details.group_name}  #{details.bite_size}  #{details.update_time} #{file}"
  end

  def max_length
    hard_links = @files.map(&:hard_link)
    owners = @files.map(&:owenr_name)
    groups = @files.map(&:group_name)
    sizez = @files.map(&:bite_size)

    {
      link: hard_links.max_by(&:length).length,
      owner: owners.max_by(&:length).length,
      group: groups.max_by(&:length).length,
      size: sizez.max_by(&:length).length
    }
  end
end

files = FileName.new.files
details = FileFormat.new(files)

details.format_files
