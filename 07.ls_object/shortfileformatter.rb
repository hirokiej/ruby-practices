# frozen_string_literal: true

class ShortFileFormatter
  COLUMN_NUMBER = 3

  def initialize(files)
    @files = files
  end

  def format
    formatted_file_list.each do |line|
      puts line.join(' ')
    end
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
