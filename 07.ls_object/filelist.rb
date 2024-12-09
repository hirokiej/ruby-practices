# frozen_string_literal: true

require_relative 'options'

class FileList
  attr_reader :files

  def initialize(options)
    @options = options
    @files = Dir.glob('*', @options.all_files? ? File::FNM_DOTMATCH : 0)
    @files.reverse! if @options.reverse_files?
  end
end
