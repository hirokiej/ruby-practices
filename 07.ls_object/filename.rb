#!/usr/bin/env ruby

class FileName
  attr_reader :files

  def initialize
    @files = Dir.glob('*')
  end
end

file_name = FileName.new
puts file_name.files
