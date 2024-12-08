#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require_relative 'fileformatter'
require_relative 'options'

options = Options.new(ARGV)

def main(options)
  files = FileList.new(options)
  file_lists = files.files

  if options.long_format
    details = FileFormatter.new(file_lists)
    details.format_files
  else
    files.display
  end
end

main(options)
