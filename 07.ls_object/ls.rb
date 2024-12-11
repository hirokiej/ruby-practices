#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require_relative 'file_list'
require_relative 'long_file_formatter'
require_relative 'short_file_formatter'
require_relative 'options'

options = Options.new(ARGV)

def main(options)
  files = FileList.new(options).files

  if options.long_format?
    puts LongFileFormatter.new(files).format
  else
    puts ShortFileFormatter.new(files).format
  end
end

main(options)
