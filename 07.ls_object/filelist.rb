# frozen_string_literal: true

require_relative 'options'

class FileList
  COLUMN_NUMBER = 3

  attr_reader :files

  def initialize(options)
    @options = options
    @files = Dir.glob('*', @options.all_files ? File::FNM_DOTMATCH : 0)
    file_reverse if options.reverse_files
  end

  def display
    formatted_file_list.each do |line|
      puts line.join(' ')
    end
  end

  def file_reverse
    @files.reverse!
  end

  private

  def aligned_file_list
    max_length = @files.max_by(&:length).size
    @files.map { |file| file.ljust(max_length + 1) }
  end

  def formatted_file_list
    aligned_file_list.each_slice(COLUMN_NUMBER)
  end
end
