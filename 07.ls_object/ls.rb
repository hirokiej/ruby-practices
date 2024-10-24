#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require_relative 'fileformat'

params = ARGV.getopts('alr')

def main(params)
  files = FileName.new
  file_lists = files.files
  if params['l']
    details = FileFormat.new(file_lists)
    details.format_files
  else
    files.display
  end
end

main(params)
