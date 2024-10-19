#!/usr/bin/env ruby
# frozen_string_literal: true

class FileName
  COLUMN_NUMBER = 3

  attr_reader :files

  def initialize
    @files = Dir.glob('*')
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
