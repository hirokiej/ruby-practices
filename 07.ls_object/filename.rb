#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'option'

class FileName
  COLUMN_NUMBER = 3

  attr_reader :files

  def initialize(options)
    @options = options
    @files = Dir.glob('*', @options.all_files ? File::FNM_DOTMATCH : 0)
  end

  def file_reverse
    @files.reverse!
  end

  def align_file_name
    max_length = @files.max_by(&:length).size
    @files.map { |file| file.ljust(max_length + 1) }
  end

  def short_format
    aligned_files = align_file_name
    aligned_files.each_slice(COLUMN_NUMBER)
  end

  def display
    short_format.each do |line|
      puts line.join(' ')
    end
  end
end
