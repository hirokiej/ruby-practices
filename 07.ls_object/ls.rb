#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require_relative 'filelist'
require_relative 'longfileformatter'
require_relative 'shortfileformatter'
require_relative 'options'

options = Options.new(ARGV)

def main(options)
  files = FileList.new(options).files

  if options.long_format?
    LongFileFormatter.new(files).format
  else
    ShortFileFormatter.new(files).format
  end
end

main(options)
