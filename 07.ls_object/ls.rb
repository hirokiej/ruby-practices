#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require_relative 'fileformat'
require_relative 'options'

options = Options.new

def main(options)
  files = FileList.new(options)
  files.file_reverse if options.reverse_files
  file_lists = files.files

  if options.long_format
    details = FileFormat.new(file_lists)
    details.format_files
  else
    files.display
  end
end

main(options)
