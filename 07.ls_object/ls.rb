#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require_relative 'fileformat'
require_relative 'option'

params = Option.new

def main(params)
  files = FileName.new(params)
  files.file_reverse if params.reverse_files
  file_lists = files.files

  if params.long_format
    details = FileFormat.new(file_lists)
    details.format_files
  else
    files.display
  end
end

main(params)
